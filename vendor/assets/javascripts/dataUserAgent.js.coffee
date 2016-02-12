# See http://rog.ie/blog/html5-boilerplate-addon.
#
# Adds data attributes to <html> element for useragent and platform and
# a class for touch support.
#
# Usage:
#
#   .cssSelector {
#     ... styles ...
#     [data-useragent*='Opera'] & {
#       ... targeted styles here ...
#     }
#   }
#
# Standard Selector Examples:
#
# - All Opera: [data-useragent*='Opera']
# - All Firefox: [data-useragent*='Firefox']
# - All Safari: [data-useragent*='Safari']
# - All Chrome: [data-useragent*='Chrome']
# - IE10+: [data-useragent*='Trident']
# - IE10 Specifically: [data-useragent*='MSIE 10']
# - Webkit: [data-useragent*='WebKit']
# - iPhone: [data-platform*='iPhone']
# - iPad: [data-platform*='iPad']
# - iPod: [data-platform*='iPod']
# - Android: [data-platform*='Android']
# - Windows: [data-platform*='Windows']
# - Mac OS X: [data-platform*='MacIntel']
#

doc = document.documentElement
doc.setAttribute "data-useragent", navigator.userAgent
doc.setAttribute "data-platform", navigator.platform
doc.className += ((if (!!("ontouchstart" of window) or !!("onmsgesturechange" of window)) then " touch" else ""))
true
