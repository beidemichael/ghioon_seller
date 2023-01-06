import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghioon_seller/Models/addCollections.dart';
import 'package:ghioon_seller/Models/addProductmodels.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileData with ChangeNotifier {
  var fullName = TextEditingController();
  var businessName = TextEditingController();
  var gender = TextEditingController();
  var dateOfBirth = TextEditingController();
  var email = TextEditingController();
  var businessNo = TextEditingController();
  var address = TextEditingController(text: "1");

  bool productDescriptionFilled = true;
  bool fixedFilled = true;

  String image = '';

  String uploadedImage = '';

  switchproductDescriptionFilled(bool productDescriptionFilledInput) {
    productDescriptionFilled = productDescriptionFilledInput;
    notifyListeners();
  }

  switchfixedFilled(bool fixedFilledInput) {
    fixedFilled = fixedFilledInput;
    notifyListeners();
  }
}
