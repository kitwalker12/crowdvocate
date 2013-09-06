var _jq = _jq || [];

(function($, _jq) {
  var fn = false;
  while (fn = _jq.pop()) {
    fn();
  }
  _jq.push = function(callback) {
    callback();
  };
})(jQuery, _jq);