import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/allProducts.dart';
import 'package:ghioon_seller/Screens/components/LongProductGrid.dart';
import 'package:ghioon_seller/Screens/components/ShortProductGrid.dart';

import '../../Shared/customColors.dart';
import '../components/storeList.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: Container(),
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
                        // ignore: prefer_const_literals_to_create_immutables
                        // shadows: <Shadow>[
                        //   const Shadow(
                        //     offset: Offset(0.0, 4.0),
                        //     blurRadius: 3.0,
                        //     color: Color.fromARGB(255, 190, 190, 190),
                        //   ),
                        // ],
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
        padding: const EdgeInsets.all(25.0),
        child: Column(children: [
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
                      child: LongProductGrid(
                        width: width,
                        title: "All \n Products",
                        icon: FontAwesomeIcons.tags,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        print("Inventory Scanner");
                      },
                      child: ShortProductGrid(
                        width: width,
                        title: "Inventory \n Scanner",
                        icon: FontAwesomeIcons.barcode,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    // ShortProductGrid(
                    //   width: width,
                    //   title: "Collections",
                    //   icon: FontAwesomeIcons.userGroup,
                    // ),
                    GestureDetector(
                      onTap: () {
                        print("Collection");
                      },
                      child: Container(
                        height: width / 2,
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: CustomColors().white),
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
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                    GestureDetector(
                      onTap: (() {
                        print("Inventory");
                      }),
                      child: LongProductGrid(
                        width: width,
                        title: "Inventory",
                        icon: FontAwesomeIcons.warehouse,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: []),
          ),
        ]),
      ),
    );
  }
}
