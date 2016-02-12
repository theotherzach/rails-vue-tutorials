$ ->
  resizeTimeout = null
  $(window).on "resize onorientationchange", ->
    cancel resizeTimeout
    resizeTimeout = delay 100, ->
      $(window).trigger 'delayedResize'
