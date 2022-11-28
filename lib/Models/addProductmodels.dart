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
  String? image;

  ImageList({
    this.image,
  });
}
