import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghioon_seller/Models/addProductmodels.dart';

final List<Range> initialData = [];

class RangeData with ChangeNotifier {
  List<int> rangeList = [];
  List<double> priceList = [];

  final from = TextEditingController();
  final to = TextEditingController();
  final price = TextEditingController();
  final from2 = TextEditingController();
  final to2 = TextEditingController();
  final price2 = TextEditingController();
  //!  Search place
//Controlling functions for search screen

  final List<Range> _range = initialData;
  List<Range> get Ranges => _range;

//function to clear out all added ranges
  removealladdress() {
    _range.clear();
    from.clear();
    to.clear();
    price.clear();
    from2.clear();
    to2.clear();
    price2.clear();
    notifyListeners();
  }

//function to add the first searching bars
  addinit() {
    _range.add(Range(
      fromcontroller: from,
      tocontroller: to,
      pricecontroller: price,
    ));
    _range.add(Range(
        fromcontroller: from2, tocontroller: to2, pricecontroller: price2));
    notifyListeners();
  }

//fuction to add a search bar on a button click, the last destination
//point will stay on the last and can add ranges in the middle

  void addToList(Range range) {
    final fromcontroller = TextEditingController();
    final tocontroller = TextEditingController();
    final pricecontroller = TextEditingController();
    _range.add(Range(
        fromcontroller: fromcontroller,
        tocontroller: tocontroller,
        pricecontroller: pricecontroller));
    notifyListeners();
  }

//function to remove one range search bar from the list

  void removeLast() {
    _range.removeLast();
    notifyListeners();
  }

  //Controlling functions for add image

  final List<ImageList> _image = [];
  List<ImageList> get Images => _image;

//function to clear out all added images
  removeallimages() {
    _image.clear();

    notifyListeners();
  }

//function to add the first add image
  addinitImages() {
    _image.add(ImageList());
    notifyListeners();
  }

//fuction to add a search bar on a button click, the last destination
//point will stay on the last and can add ranges in the middle

  void addToImageList(ImageList image) {
    _image.add(ImageList());
    notifyListeners();
  }

//function to remove one range search bar from the list

  void removeImage(ImageList image) {
    _image.remove(image);
    notifyListeners();
  }
}
