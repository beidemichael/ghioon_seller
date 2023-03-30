// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ghioon_seller/Providers/language_provider.dart';
import 'package:ghioon_seller/Shared/customColors.dart';
import 'package:ghioon_seller/Shared/language.dart';
import 'package:ghioon_seller/Shared/loading.dart';
import 'package:provider/provider.dart';

import '../../../../Models/models.dart';
import '../Product/ProductDetail/productCard.dart';
import '../Product/ProductDetail/productDetail.dart';

class ScannedProducts extends StatefulWidget {
  @override
  State<ScannedProducts> createState() => _ScannedProductsState();
}

class _ScannedProductsState extends State<ScannedProducts> {
  TextStyle textStyle = const TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    var languageprov = Provider.of<LanguageProvider>(context);
    final products = Provider.of<List<ProductBar>>(context);
    print('Product list dialog: ' + products.length.toString());
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          contentPadding: const EdgeInsets.all(0),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      Language().result[languageprov.LanguageIndex],
                      style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Divider(
                  color: Colors.grey,
                  height: 4.0,
                ),
                products == null
                    ? Loading()
                    : products.isEmpty
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Center(
                                child: Text(
                                  Language().no_product_with_barcode[
                                      languageprov.LanguageIndex],
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductDetail(
                                                product: Product(
                                                    productId: products[index]
                                                        .productId,
                                                    name: products[index].name,
                                                    description: products[index]
                                                        .description,
                                                    fixed:
                                                        products[index].fixed,
                                                    price:
                                                        products[index].price,
                                                    rangeFrom: products[index]
                                                        .rangeFrom,
                                                    rangeTo:
                                                        products[index].rangeTo,
                                                    Product_Type:
                                                        products[index]
                                                            .Product_Type,
                                                    Product_collection:
                                                        products[index]
                                                            .Product_collection,
                                                    rating:
                                                        products[index].rating,
                                                    category: products[index]
                                                        .category,
                                                    image:
                                                        products[index].image,
                                                    inStock:
                                                        products[index].inStock,
                                                    quantity: products[index]
                                                        .quantity,
                                                    documentId: products[index]
                                                        .documentId,
                                                    video:
                                                        products[index].video,
                                                    barcode:
                                                        products[index].barcode,
                                                    viewsTime: products[index]
                                                        .viewsTime),
                                              )),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ProductList(
                                      title: products[index].name,
                                      stock:
                                          products[index].quantity.toString(),
                                      image: products[index].image,
                                      edit: true,
                                      item: products[index],
                                      index: index,
                                      // view: products[index].viewsTime,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      color: CustomColors().blue,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0)),
                    ),
                    child: Center(
                      child: Text(Language().close[languageprov.LanguageIndex],
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w300)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
