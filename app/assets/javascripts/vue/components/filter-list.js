;(function () {
  'use strict'

  var FilterList = Vue.extend({
    props: {

      people: {
        type: Array,
        coerce: function (val) {
          return JSON.parse(val)
        },
      },

    },

    template: JST['vue/components/filter-list-template'],

    data: function () {
      return {
        message: 'The template lives in filter-list-template.jst.str'
      }
    }
  })

  Vue.component('vue-filter-list', FilterList)
}());
