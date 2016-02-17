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
