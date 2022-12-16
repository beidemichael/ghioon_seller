import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Models/addProductmodels.dart';
import 'package:ghioon_seller/Providers/RangeProvider.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/ProductDetail/productDetail.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/addProduct.dart';
import 'package:ghioon_seller/Shared/constants.dart';
import 'package:ghioon_seller/Shared/customColors.dart';
import 'package:provider/provider.dart';

import '../../../Models/models.dart';
import 'ProductDetail/productCard.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({super.key});

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<RangeData>(context);
    final products = Provider.of<List<Product>>(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
              actions: [
                GestureDetector(
                  onTap: () {
                    appState.removeallcontrollers();
                    appState.removeallimages();
                    appState.addinit();
                    appState.addToImageList(ImageList(name: 'first'));
                    print("image added");

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddProduct()),
                    );
                  },
                  child: Center(
                    child: Icon(
                      FontAwesomeIcons.plus,
                      size: 25.0,
                      color: CustomColors().white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
              centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text('All Products',
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700)),
                ],
              ),
              // excludeHeaderSemantics: true,
              backgroundColor: CustomColors().blue,
              // automaticallyImplyLeading: false,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white)),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
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
                                product: products[index],
                              )),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProductList(
                      title: products[index].name,
                      stock: products[index].quantity.toString(),
                      image: products[index].image,
                      edit: true,
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
