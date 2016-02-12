$ ->
  # Disable hover on scroll for smoother scrolling
  # - http://www.thecssninja.com/javascript/pointer-events-60fps

  body = document.body
  scrollTimer = null
  disabledClass = "is--hoverDisabled"

  window.addEventListener "scroll", (->
    cancel scrollTimer
    unless body.classList.contains disabledClass
      body.classList.add disabledClass

    scrollTimer = delay 300, ->
      body.classList.remove disabledClass
  ), false
