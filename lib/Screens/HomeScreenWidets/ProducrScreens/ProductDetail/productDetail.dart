import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/ProductDetail/ProductDetailWidgets.dart/images.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/ProductDetail/ProductDetailWidgets.dart/titleAndDescription.dart';
import 'package:video_player/video_player.dart';

import '../../../../Shared/constants.dart';

class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            ImagesList(product: widget.product),
            TitleAndDescription(product: widget.product),
          ],
        ));
  }
}
