import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Providers/AppState.dart';
import 'package:ghioon_seller/Providers/RangeProvider.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProductScreens/Collection/collections.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProductScreens/InventoryScan/InventoryScanner.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProductScreens/Product/allProducts.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProductScreens/graph/piechart.dart';
import 'package:ghioon_seller/Screens/components/LongProductGrid.dart';
import 'package:ghioon_seller/Screens/components/ShortProductGrid.dart';
import 'package:provider/provider.dart';

import '../../Models/models.dart';
import '../../Service/Product/readProduct.dart';
import '../../Shared/customColors.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      // drawer: Drawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text('Products',
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
      body: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AllProduct()),
                              );
                            },
                            child: ChangeNotifierProvider(
                              create: (context) => RangeData(),
                              child: LongProductGrid(
                                width: width,
                                title: "All \n Products",
                                icon: FontAwesomeIcons.tags,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("Collection");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Collections()), //CollectionProvider()) //
                              );
                            },
                            child: Container(
                              height: (width / 2) + 45,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: CustomColors().white),
                                color: CustomColors().blue,
                                borderRadius: BorderRadius.circular(25.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        0, 4), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.userGroup,
                                        color: CustomColors().white,
                                        size: 50,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text("Collections",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: width / 17,
                                              color: CustomColors().white,
                                              fontWeight: FontWeight.w600))
                                    ]),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          // GestureDetector(
                          //   onTap: (() {
                          //     print("Inventory");
                          //   }),
                          //   child: LongProductGrid(
                          //     width: width,
                          //     title: "Inventory",
                          //     icon: FontAwesomeIcons.warehouse,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    print("Inventory Scanner");
                    appState.barCode = '3';
                    Provider.of<AppState>(context, listen: false).refresh();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const BarcodeScannerDemo()), //AddProductProvider()),
                    );
                  },
                  child: Container(
                    width: width,
                    child: ShortProductGrid(
                      width: width,
                      title: "Barcode \n Scanner",
                      icon: FontAwesomeIcons.barcode,
                    ),
                  ),
                ),
                // Expanded(
                //   child: ListView(
                //       physics: const BouncingScrollPhysics(
                //           parent: AlwaysScrollableScrollPhysics()),
                //       children: []),
                // ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(width: 400, height: 400, child: const PieChartChart())
              ],
            ),
          ),
        ],
      ),
    );
  }
}
