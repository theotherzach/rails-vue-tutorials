exports = exports ? @

# Better syntax for setting timeouts in coffeescript

exports.delay = (ms, func) -> setTimeout func, ms
exports.cancel = (id) -> clearTimeout id
