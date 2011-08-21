(function() {
  var s;
  s = require('./../store');
  s.nuke(function() {
    return s.save({
      a: 1
    }, function() {
      return s.all(console.log);
    });
  });
}).call(this);
