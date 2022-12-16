import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ghioon_seller/Models/models.dart';

import '../Models/addCollections.dart';

class CollectionData with ChangeNotifier {
  File? Photo;
  bool isLoading = false;
  final collectionName = TextEditingController();
  final collectionDescription = TextEditingController();
  final List<Product> collectionItems = [];
  bool productDescriptionFilled = true;
  List<String> imageList = [];
  final List<CollectionImage> _collectionimage = [];
  List<CollectionImage> get collectionImage =>
      _collectionimage; // image holder for collection image

  //function to add the first add image
  addinitCollectionImages() {
    _collectionimage.add(CollectionImage());
    notifyListeners();
  }

  removeallimages() {
    _collectionimage[0].photo = null;
    imageList.clear();

    notifyListeners();
  }

  cleanallcontrollers() {
    collectionName.clear();
    collectionDescription.clear();
    notifyListeners();
  }

  switchproductDescriptionFilled(bool productDescriptionFilledInput) {
    productDescriptionFilled = productDescriptionFilledInput;
    notifyListeners();
  }
}
