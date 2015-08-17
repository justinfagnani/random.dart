library random;

import 'dart:math' show Random, Point, sqrt, log, PI, cos, sin;

/**
 * Returns an infinite-length [Iterable] of normally distributed numbers with
 * mean [mean] and standard deviation [standardDeviation].
 */
Iterable<double> gaussian({
    double mean: 0.0,
    double standardDeviation: 1.0,
    Random random}) sync* {

  random = random ?? new Random();
  double x1, x2, w;

  while (true) {
    do {
      x1 = random.nextDouble() * 2.0 - 1.0;
      x2 = random.nextDouble() * 2.0 - 1.0;
      w = x1 * x1 + x2 * x2;
    } while (w >= 1.0);

    w = sqrt((-2.0 * log(w)) / w) * standardDeviation;
    yield x1 * w + mean;
    yield x2 * w + mean;
  }
}

/**
 * Returns an infinite-length [Iterable] of exponentially distributed numbers.
 */
Iterable<double> exponential({double rate: 1.0, Random random}) sync* {
  random = random ?? new Random();
  if (rate < 0) {
    throw new ArgumentError();
  }

  while (true) {
    yield -1.0 * log(random.nextDouble()) / rate;
  }
}

/**
 * Returns an infinite-length [Iterable] of [Point]s uniformily distributed
 * around a unit circle.
 */
Iterable<Point> pointsOnCircle({Random random}) sync* {
  random = random ?? new Random();
  final tau = 2.0 * PI;

  while (true) {
    double theta = tau * random.nextDouble();
    yield new Point(cos(theta), sin(theta));
  }
}

/**
 * Generates a random permutation of integers from 0 to size - 1.
 */
List<int> permutation(int size, {Random random}) {
  random = random ?? new Random();
  var list = new List(size);
  if (size == 0) return list;
  list[0] = 0;
  for (int i = 1; i < size; i++) {
    var j = random.nextInt(i);
    list[i] = list[j];
    list[j] = i;
  }
  return list;
}
