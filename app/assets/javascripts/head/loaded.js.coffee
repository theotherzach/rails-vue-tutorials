loaded = ->
  $("body").addClass "is--loaded"

if window.addEventListener
  window.addEventListener "load", loaded, false

else if window.attachEvent
  window.attachEvent "onload", loaded

else
  preExistingOnload = window.onload
  window.onload = ->
    setTimeout loaded, 0
    preExistingOnload?()
