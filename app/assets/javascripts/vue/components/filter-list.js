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
