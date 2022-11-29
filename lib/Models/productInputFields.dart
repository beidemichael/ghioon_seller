import 'package:flutter/foundation.dart';

import 'addProductmodels.dart';

class ProductInputfields with ChangeNotifier {
  String productName = '';
  String description = '';
  double fixedNewPrice = 0.0;
  double fixedOldPrice = 0.0;
  double fixedCostPerItem = 0.0;
  bool fixed = true;
  List<Range> range = [];
}
