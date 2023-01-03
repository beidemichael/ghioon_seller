import 'package:collection/collection.dart';

class Point {
  final x;
  final y;
  Point({required this.x, required this.y});
}

List<Point> get storeview {
  final data = <double>[2, 4, 6, 11, 3, 60, 4];
  return data
      .mapIndexed(((index, element) => Point(x: index.toDouble(), y: element)))
      .toList();
}

List<Point> get orders {
  final data = <double>[20, 15, 32, 45, 28, 25];
  return data
      .mapIndexed(((index, element) => Point(x: index.toDouble(), y: element)))
      .toList();
}
