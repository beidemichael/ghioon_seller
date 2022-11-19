import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    return Scaffold(
      drawer: Container(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text('Products',
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            iconTheme: IconThemeData(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: width / 2 + 40,
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: CustomColors().blue),
                        color: CustomColors().white,
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(0, 4), // changes position of shadow
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
                                FontAwesomeIcons.tags,
                                color: CustomColors().blue,
                                size: 50,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text("All \n Products",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: width / 14,
                                      color: CustomColors().blue,
                                      fontWeight: FontWeight.w600))
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: width / 2,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: const Color.fromARGB(255, 224, 224, 224)),
                        color: CustomColors().blue,
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.barcode,
                                color: CustomColors().white,
                                size: 50,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text("Inventory \n Scanner",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: width / 17,
                                      color: CustomColors().white,
                                      fontWeight: FontWeight.w600))
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
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
                            offset: Offset(0, 4), // changes position of shadow
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
                              SizedBox(
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
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: width / 2 + 40,
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: CustomColors().blue),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(0, 4), // changes position of shadow
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
                                FontAwesomeIcons.warehouse,
                                color: CustomColors().blue,
                                size: 50,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text("Inventory",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: width / 14,
                                      color: CustomColors().blue,
                                      fontWeight: FontWeight.w600))
                            ]),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: []),
          ),
        ]),
      ),
    );
  }
}
