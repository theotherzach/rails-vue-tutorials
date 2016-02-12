$ ->
  $.ajax '/svg/icons.svg',
    dataType: 'html'
    success: (data) ->
      $('head').append data
