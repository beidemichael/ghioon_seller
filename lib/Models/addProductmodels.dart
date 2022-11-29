import 'dart:io';

import 'package:flutter/material.dart';

class Range {
  TextEditingController? fromcontroller;
  TextEditingController? tocontroller;
  TextEditingController? pricecontroller;
  Range({
    this.fromcontroller,
    this.tocontroller,
    this.pricecontroller,
  });
}

class ImageList {
  File? photo;
  String? name;
  ImageList({this.photo, this.name});
}
