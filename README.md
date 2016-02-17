# RailsVue

This repo is designed to be a testing ground for using Rails with Vue.js

## Setup

+ `bundle && bundle exec rake db:setup`

## Filter List Tutorial


This tutorial starts with a Rails rendered list and leads you through the steps where you should be able to render the same list in `Vue` and add a `<input type="text">` filter. All shell commands assume that you're in the project root. All browser references assume that you're in the `/filter-list`route.


### Downloading Vue

Commit: e20bb86

+ Crab Vue with my JavaScript package manager of choice: `curl -LO http://vuejs.org/js/vue.js`
+ `mkdir -p vendor/assets/javascripts/defer`
+ copy vue to defer via `mv vue.js !$` (!$ references the argument to the previous shell command, or vendor/assets/javascripts/defer` in our case. If your terminal is set to treat Alt as the meta key, you could also type `cp vue.js ` and then `alt-.` to grab the last argument.)
+ Add the following to application.defer.coffee under "VENDOR FOLDER": `#= require_tree ../../../vendor/assets/javascripts/defer`
+ `open http://localhost:3000/filter-list`, hit command-alt j to open the JS console, and type `Vue` to verify that the `Vue` object is available. 


### Vue Directory Structure

We're going to assume multiple Vue components across multiple Rails routes, so lets set up our directory structure in a way that protects us from Sprockets. Our strategy is to load Vanilla JavaScript functions first, followed by Vue filters, followed by Vue components, and finally the single Vue application. 

Commit: 1c1e328

+ `mkdir app/assets/javascripts/vue`
+ `touch !$/manifest.js`
+ `mkdir !$` hit tab, backspace over manifest.js and replace with `components` and then run the command you should be looking at: `mkdir app/assets/javascripts/vue/components`
+ `touch !$/.gitkeep` or `app/assets/javascripts/vue/components/.gitkeep`
+ `mkdir app/assets/javascripts/vue/filters`
+ `touch !$/.gitkeep` or `touch app/assets/javascripts/vue/filters/.gitkeep`
+ `mkdir app/assets/javascripts/vue/services`
+ `touch !$/.gitkeep` or `touch app/assets/javascripts/vue/services/.gitkeep`
+ `touch app/assets/javascripts/vue/main.js`
+ in `application-defer.coffee`, directly below `require_tree ./defer` add `#= require ./vue/manifest`
+ In `vue/manifest.js` make sure the following appear in this order:
  + //= require_tree ./services
  + //= require_tree ./filters
  + //= require_tree ./components
  + //= require ./main
+ in `main.js` add the following:

```
;(function () {
  'use strict'
  console.log('you can find me in main.js')
}());
```
+ Verify that `'you can find me in main.js'` appears in the browser's console.

### The Vue App Instance

My current thinking is that it's easier to have a single Vue instance for the entire Rails app with components that may or may not get loaded depending on the Rails route in question. I'm open to suggestions on this as I'm not a fan of always having an active Vue instance, but the alternative is problematic for reasons I won't get into here.

Commit: 1be037f

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

Commit: f8a1ac2


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

Commit: 68c027c

+ delete the code from the previous step and verify that "Do NOT do this!" is no longer displayed at /filter-list

### Create a filter-list component

Now that we've validated that Vue is functional by doing the simplest thing that's stupid, let's declare a component and do it in a more controlled way.

Commit: bad91c3

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

Commit: fd8b89b


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

Commit: d5b83b7

+ Verify that "You can do this, but it sucks." no longer appears in the DOM

### A slightly less bad idea: JST templates

Have you ever heard of JST templates? How about ECO or EJS? Having fought in the Backbone/ Rails wars, I've seen these templates and they're not great. Luckily, we can subvert their purpose and get our string HTML templates in their own files by using the [sprockets-jst-str](https://github.com/chetan/sprockets-jst-str) gem.

Commit: 8bf2f67

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

Commit: 81d0346

+ In `filter-list.js` add the following to our component config: `props: ['people'],`
+ in filter_list.html.haml : `%vue-filter-list{ people: @people.to_json }`
+ Refresh, do the vue devtools dance, (Live, Refresh, Live) and note that `VueFilterList`'s people is a json string, not an array. That won't do us any good.
+ [Coerce](http://vuejs.org/guide/components.html#Prop_Validation) our string into an array.
+ Refresh, vue devtools dance, and verify that People is an array with 100 members.


### Filter The List

I'm running low on time, but you may be able to filter the list yourself with the following links:

+ [Text Input Binding](http://vuejs.org/guide/forms.html#Text)
+ [List Rendering](http://vuejs.org/guide/list.html)
+ [filterBy](http://vuejs.org/api/#filterBy)
