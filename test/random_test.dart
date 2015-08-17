library random_test;

import 'dart:math' show Random, sqrt;
import 'package:random/random.dart' as random_lib;
import 'package:test/test.dart';

sum(l) => l.reduce((a, b) => a + b);
mean(l) => sum(l) * (1.0 / l.length); // use * so this works with Point
variance(l) {
  var _mean = mean(l);
  return mean(l.map((x) => (x - _mean) * (x - _mean)));
}
const int seed = 42;
final random = new Random(42);

main() {

  group('gaussian', () {

    test('with no parameters has mean 0 and variance 1', () {
      var g = random_lib.gaussian(random: random).take(10000);
      expect(mean(g), closeTo(0.0, 0.05), reason: 'mean');
      expect(variance(g), closeTo(1.0, 0.05), reason: 'variance');
    });

    test('has given mean', () {
      var g = random_lib.gaussian(mean: 100.0, random: random).take(10000);
      expect(mean(g), closeTo(100.0, 0.05), reason: 'mean');
      expect(variance(g), closeTo(1.0, 0.05), reason: 'variance');
    });

    test('has given standard deviation', () {
      var g = random_lib.gaussian(standardDeviation: 4.0, random: random).take(10000);
      expect(mean(g), closeTo(0.0, 0.05), reason: 'mean');
      expect(sqrt(variance(g)), closeTo(4.0, 0.05), reason: 'variance');
    });

  });

  group('exponential', () {

    test('with no parameters has mean 1 and variance 1', () {
      var g = random_lib.exponential(random: random).take(10000);
      expect(mean(g), closeTo(1.0, 0.05), reason: 'mean');
      expect(variance(g), closeTo(1.0, 0.05), reason: 'variance');
    });

    test('has mean 1/rate and variance 1/rate^2', () {
      var g = random_lib.exponential(rate: 5.0, random: random).take(10000);
      expect(mean(g), closeTo(1.0 / 5.0, 0.05), reason: 'mean');
      expect(variance(g), closeTo(1.0 / 25.0, 0.05), reason: 'variance');
    });

  });

  group('pointsOnCircle', () {

    test('generates points on the unit circle', () {
      var g = random_lib.pointsOnCircle(random: random).take(10000);
      var r = g.map((p) => p.magnitude);
      expect(r, everyElement(closeTo(1.0, 0.05)));
    });

    test('has centroid at origin', () {
      var g = random_lib.pointsOnCircle(random: random).take(10000);
      var centroid = mean(g);
      expect(centroid.x, closeTo(0.0, 0.05), reason: 'x');
      expect(centroid.y, closeTo(0.0, 0.05), reason: 'y');
    });

  });

  group('permutation', () {

    test('generates a valid permutation', () {
      var p = random_lib.permutation(100);
      var sorted = new List.from(p)..sort();
      expect(sorted, new List.generate(100, (i) => i));
    });

  });

}
