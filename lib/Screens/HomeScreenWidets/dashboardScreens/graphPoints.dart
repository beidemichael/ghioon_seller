import 'package:collection/collection.dart';

class Point {
  final x;
  final y;
  Point({required this.x, required this.y});
}

List<Point> get storeview {
  final data = <double>[0, 0, 0, 0, 0, 0, 0];
  return data
      .mapIndexed(((index, element) => Point(x: index.toDouble(), y: element)))
      .toList();
}

List<Point> get orders {
  final data = <double>[0, 0, 0, 0, 0, 0];
  return data
      .mapIndexed(((index, element) => Point(x: index.toDouble(), y: element)))
      .toList();
}
