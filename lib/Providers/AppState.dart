import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghioon_seller/Models/addCollections.dart';
import 'package:ghioon_seller/Models/addProductmodels.dart';
import 'package:image_picker/image_picker.dart';

class AppState with ChangeNotifier {
  String barCode = '4';

  refresh() {
    print('AppStateBarcode: '+barCode);
    notifyListeners();
  }
}
