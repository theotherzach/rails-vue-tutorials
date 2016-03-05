# RailsVue

This repo is designed to be a testing ground for using Rails with Vue.js

## Setup

+ clone this repo and cd into the project directory
+ `cp config/database.yml.template config/database.yml`
+ `cp config/eye.yml.erb.template config/eye.yml.erb`
+ `cp config/secrets.yml.template config/secrets.yml`
+ `bundle && bundle exec rake db:setup`

## Filter List Tutorial

This tutorial starts with a Rails rendered list and leads you through the steps where you should be able to render the same list in `Vue` and add a `<input type="text">` filter. All shell commands assume that you're in the project root. All browser references assume that you're in the `/filter-list`route.


### Note The Server Side Implementation

This is `/filter-list`

![Unfiltered list](https://raw.githubusercontent.com/theotherzach/rails-vue-tutorials/master/unfiltered_list.png)

Note: Since the app generates names randomly, you'll probably need to filter by a different name. Just pick a name from the list, throw it into the input box, and verify that it works.

![Filtered list](https://raw.githubusercontent.com/theotherzach/rails-vue-tutorials/master/filtered_list.png)

Don't worry about how the server side code is implemented. We just don't care. The important part is that we're going to convert the server side filtering to client side filtering using Vue.


### The Vue App Instance

Start by creating a Vue app instance to rule them all.

Commit: [1be037f](https://github.com/theotherzach/rails-vue-tutorials/commit/1be037f2ff59d5bd65998af7c91b34c78fbda108)

+ In `vue/main.js`, make the file look like this:
```
;(function () {
  'use strict'
  new Vue({
    el: 'html'
  })
}());
```

### Mixed Templates, A Bad Idea

We do not want to mix our Rails templates and our Vue templates for a variety of reasons, but I'm mostly concerned with how hard it is to keep code straight when boundaries are blurred. We're going to mix templates for demonstrative purposes only.

Commit: [f8a1ac2](https://github.com/theotherzach/rails-vue-tutorials/commit/f8a1ac288f06ee5bf74364ac7570d7faecbefaf2)


+ In `vue/main.js`, make the constructor look like this:

```JavaScript
;(function () {
  'use strict'
  new Vue({
    el: 'html',
    data: {
      message: 'Do NOT do this!'
    },
  })
}());
```

+ in `app/views/layouts/application.html.haml`, add the following right below `%body`: `.bad {{ message }}`
+ Verify that "Do NOT do this!" appears right above the `<h1>` in http://localhost:3000/filter-list

### Revert Mixed Templates

Commit: [68c027c](https://github.com/theotherzach/rails-vue-tutorials/commit/68c027c49a2a3169c682ffd6504f3b71eaa0f955)

+ delete the code from the previous step and verify that "Do NOT do this!" is no longer displayed at /filter-list

### Create a filter-list component

Now that we've validated that Vue is functional by doing the simplest thing that's stupid, let's declare a component and do it in a more controlled way.

Commit: [bad91c3](https://github.com/theotherzach/rails-vue-tutorials/commit/bad91c3d33b31ecc4605d2aec2987d1f7fd50636)

+ `touch app/assets/javascripts/vue/components/filter-list.js`
+ In `app/views/pages/filter_list.html.haml`, right below `.section`, add a custom html5 element: `<vue-filter-list>`. (The "vue-" prefix is to communicate to anybody looking at the file that "here be JavaScript!."
+ Refresh the browser and note the warning:

> [Vue warn]: Unknown custom element: <vue-filter-list> - did you register the component correctly? For recursive components, make sure to provide the "name" option.

+ In `touch app/assets/javascripts/vue/components/filter-list.js`, create a new Vue component that's registered to the `vue-filter-list` element.

```JavaScript
;(function () {
  'use strict'

  var FilterList = Vue.extend({
  })

  Vue.component('vue-filter-list', FilterList)
}());
```

### Another Bad Idea: Inline Templates

This idea is slightly less-bad than the last bad idea. I've used inline string templates before for super small components, but in general we'll want a solution that lets us put templates in dedicated files. 

Commit: [fd8b89b](https://github.com/theotherzach/rails-vue-tutorials/commit/fd8b89b28ec37e80562802ca7af49e4581ddc9ab)


+ In `filter-list.js`

```JavaScript
;(function () {
  'use strict'

  var FilterList = Vue.extend({
    template: '<p>{{ message }}</p>',

    data: function () {
      return {
        message: 'You can do this, but it sucks.'
      }
    },
  })

  Vue.component('vue-filter-list', FilterList)
}());
```
+ Refresh the browser and verify that "You can do this, but it sucks." appears in the DOM
+ If you have Vue Dev Tools installed, open that in the Chrome dev tools panel, click "live" click "refresh" and then click "live" and then click `VueFilterList` and then click "Send to Console"
+ From the console, check out what Vue Dev Tools sent us by taking a look at `$vm`

### Revert Inline Templates

Commit: [d5b83b7](https://github.com/theotherzach/rails-vue-tutorials/commit/d5b83b7243ec55c650f15fd5f206e8e46ef2bf83)

+ Verify that "You can do this, but it sucks." no longer appears in the DOM

### A slightly less bad idea: JST templates

Have you ever heard of JST templates? How about ECO or EJS? Having fought in the Backbone/ Rails wars, I've seen these templates and they're not great. Luckily, we can subvert their purpose and get our string HTML templates in their own files by using the [sprockets-jst-str](https://github.com/chetan/sprockets-jst-str) gem.

Commit: [8bf2f67](https://github.com/theotherzach/rails-vue-tutorials/commit/8bf2f675cfe85ae9b0aea6063318b38e96e039b8)

+ add `gem "sprockets-jst-str"` to the Gemfile and `bundle install`
+ restart the Rails server because asset gem.
+ `touch app/assets/javascripts/vue/components/filter-list-template.jst.str`(The "-template" postfix prevents sprockets file name collisions with the component file. I don't like it either.)
+ in `filter-list-template.jst.str`, add: `<h2>{{ message }}</h2>`
+ Refresh the browser and verify that `JST` is defined.
+ Change `filter-list.js` to look like this:

```JavaScript
;(function () {
  'use strict'

  var FilterList = Vue.extend({
    template: JST['vue/components/filter-list-template'],

    data: function () {
      return {
        message: 'The template lives in filter-list-template.jst.str'
      }
    }
  })

  Vue.component('vue-filter-list', FilterList)
}());
```

+ Refresh the browser and verify that "The template lives..." is visible in the DOM

### Bootstrapping data

In general, it is cleaner to get our application's JSON from an ajax call. In cases where Vue is rendering a critical DOM element, such as a list that's supposed to be visible in the DOM, it may be better to bootstrap some or all of the data to prevent rendering delays. Regardless, I often bootstrap data as an intermediary step before moving to an API endpoint when refactoring a Rails view to a client rendered view as doing so allows me to deploy smaller steps.

Commit: [81d0346](https://github.com/theotherzach/rails-vue-tutorials/commit/81d03466b045fc063581d2bdd1a16bd5b255ed2f)

+ In `filter-list.js` add the following to our component config: `props: ['people'],`
+ in filter_list.html.haml : `%vue-filter-list{ people: @people.to_json }`
+ Refresh, do the vue devtools dance, (Live, Refresh, Live) and note that `VueFilterList`'s people is a json string, not an array. That won't do us any good. (Note: if you remove the vue devtools and re-install you may not need to do this dance.)
+ [Coerce](http://vuejs.org/guide/components.html#Prop_Validation) our string into an array.
+ Refresh, vue devtools dance, and verify that People is an array with 100 members.

### Mark off a place to work

Commit: [af0cbd3](https://github.com/theotherzach/rails-vue-tutorials/commit/af0cbd393be5ae7775bb8c087a8b16e954f4f6a3)

I like to keep the old implementation around while I'm working on the new one. Let's clearly mark which one is which.

+ In `app/views/pages/filter_list.html.haml` add some `h2` tags to denote which one is which.

```haml
%h2 Client Side
.section
  %vue-filter-list{ people: @people.to_json }

%h2 Server Side
.section.filterList
  .filterList-control
    -# etcetera
```

+ Let's verify that we've got the proper list of people by updating `filter-list-template.jst.str`
+ Note that the final markup is up to you, this is just validating that we're passing the data in correctly

```html
<ul>
  <li v-for="person in people">{{ person.first_name }}</li>
</ul>
```

+ Verify that you are seeing a list of first names in the browser

### Filter The List

I'm running low on time, but you may be able to filter the list yourself with the following links:

+ [Text Input Binding](http://vuejs.org/guide/forms.html#Text)
+ [List Rendering](http://vuejs.org/guide/list.html)
+ [filterBy](http://vuejs.org/api/#filterBy)
