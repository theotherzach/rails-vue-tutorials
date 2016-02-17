# This file should be restricted solely to js that is NOT essential to page
# loading. This file will not load until after the load event has been
# triggered. Scripts that need to load before the page can finish rendering
# should be placed in the foot.js file.
#
# This file will be deferred using the technique described here:
# http://www.feedthebot.com/pagespeed/defer-loading-javascript.html

# GEMS


# VENDOR FOLDER
#= require_tree ../../../vendor/assets/javascripts/defer

# ASSETS FOLDER
#
#= require_tree ./defer
#= require ./vue/manifest


#= require_self
