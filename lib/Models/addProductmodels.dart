import 'dart:io';

import 'package:flutter/material.dart';

class Range {
  TextEditingController? fromcontroller;
  TextEditingController? tocontroller;
  TextEditingController? pricecontroller;
  Range({
    required this.fromcontroller,
    required this.tocontroller,
    required this.pricecontroller,
  });
}

class ImageList {
  File? photo;
  String? name;
  ImageList({this.photo, this.name});
}
