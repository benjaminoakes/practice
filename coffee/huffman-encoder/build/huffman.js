(function() {
  var foo;

  foo = function() {
    return 'bar';
  };

  module.exports = {
    foo: foo
  };

}).call(this);
