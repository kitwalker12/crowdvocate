// handle window.console if console.log isn't available. Define an empty function here
function emptyFunction() { }
if (window.console === undefined) {
  window.console = {
    log: emptyFunction,
    error: emptyFunction,
    info: emptyFunction,
    trace: emptyFunction
  };
}

// init namespace
window.app = {};
window.app.myapp = {};

//Following code can be put in other JS files which are included in the tree
(function ($, app) {
  var $window = $(window);

  $(document).ready(function() {
    //Other Initializers for plugins

  });
}(jQuery, app.myapp));