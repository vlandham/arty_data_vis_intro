// Inspired by Lee Byron's test data generator.
function bumpLayer(n, o) {

  function bump(a) {
    var x = 1 / (.1 + Math.random()),
        y = 2 * Math.random() - .5,
        z = 10 / (.1 + Math.random());
    for (var i = 0; i < n; i++) {
      var w = (i / n - y) * z;
      a[i] += x * Math.exp(-w * w);
    }
  }

  var a = [], i;
  for (i = 0; i < n; ++i) a[i] = o + o * Math.random();
  for (i = 0; i < 5; ++i) bump(a);
  return a.map(function(d, i) { return {x: i, y: Math.max(0, d)}; });
}


// http://stackoverflow.com/questions/1527803/generating-random-numbers-in-javascript-in-a-specific-range
function getRandomArbitrary(min, max) {
    return Math.random() * (max - min) + min;
}

/**
 * Returns a random integer between min (inclusive) and max (inclusive)
 * Using Math.round() will give you a non-uniform distribution!
 */
function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

(function() {
  var count = 0,
      overshoot = 300;

  function whenBoundsVisible(computeBounds, callback) {
    var id = ".visible-" + ++count,
        self = d3.select(window),
        bounds;

    if (document.readyState === "loading") self.on("load" + id, loaded);
    else loaded();

    function loaded() {
      self
          .on("resize" + id, resized)
          .on("scroll" + id, scrolled)
          .each(resized);
    }

    function resized() {
      bounds = computeBounds();
      if (bounds[1] < bounds[0]) bounds.reverse();
      scrolled();
    }

    function scrolled() {
      if (bounds[0] <= pageYOffset && pageYOffset <= bounds[1]) {
        callback(null);
        self.on(id, null);
      }
    }
  }

  beforeVisible = function(element, callback) {
    return whenBoundsVisible(function() {
      var rect = element.getBoundingClientRect();
      return [
        rect.top + pageYOffset - innerHeight - overshoot,
        rect.bottom + pageYOffset + overshoot
      ];
    }, callback);
  };

  whenFullyVisible = function(element, callback) {
    return whenBoundsVisible(function() {
      var rect = element.getBoundingClientRect();
      return [
        rect.bottom + pageYOffset - innerHeight,
        rect.top + pageYOffset
      ];
    }, callback);
  };
})();

