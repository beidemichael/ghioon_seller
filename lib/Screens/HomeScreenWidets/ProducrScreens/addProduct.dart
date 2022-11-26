import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Screens/components/BlueButton.dart';
import 'package:ghioon_seller/Screens/components/image_picker.dart';
import 'package:ghioon_seller/Shared/customColors.dart';

import '../../components/textFormField.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final productName = TextEditingController();
  final description = TextEditingController();
  final fixedPrice = TextEditingController();
  final oldPrice = TextEditingController();
  final cost = TextEditingController();
  bool fixed = true;
  int Qty = 0;
  add() {
    Qty = Qty + 1;
  }

  minus() {
    Qty > 0 ? Qty = Qty - 1 : Qty = 0;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text('Add Products',
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
            iconTheme: IconThemeData(color: CustomColors().white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Container(
              height: height / 7,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: const Color.fromARGB(255, 207, 207, 207)),
                color: CustomColors().white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
                child: Row(children: [
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(Icons.add_a_photo),
                  //   color: CustomColors().blue,
                  //   iconSize: 80,
                  // ),
                  AddImage(),
                  Flexible(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color:
                                    const Color.fromARGB(255, 207, 207, 207)),
                            color: CustomColors().white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color:
                                    const Color.fromARGB(255, 207, 207, 207)),
                            color: CustomColors().white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color:
                                    const Color.fromARGB(255, 207, 207, 207)),
                            color: CustomColors().white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              )),
          SizedBox(height: 15),
          Flexible(
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: const Color.fromARGB(255, 207, 207, 207)),
                  color: CustomColors().white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: [
                        TextFormFieldProduct(
                            "Enter Product Name", productName, "Product Name"),
                        TextFormFieldProDescription(
                            "Description", description, "Description"),
                        Text(
                          "Price",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Flexible(
                                child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  fixed = !fixed;
                                });
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: fixed
                                          ? CustomColors().white
                                          : CustomColors().blue),
                                  color: fixed
                                      ? CustomColors().blue
                                      : CustomColors().white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "Fixed",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: fixed
                                          ? CustomColors().white
                                          : CustomColors().blue),
                                )),
                              ),
                            )),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                                child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  fixed = !fixed;
                                });
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: fixed
                                          ? CustomColors().blue
                                          : CustomColors().white),
                                  color: fixed
                                      ? CustomColors().white
                                      : CustomColors().blue,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "Range",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: fixed
                                          ? CustomColors().blue
                                          : CustomColors().white),
                                )),
                              ),
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        fixed
                            ? Flexible(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Fixed Price",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: TextFormFieldWithOutLabel(
                                                  'New Price', fixedPrice)),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                              child: TextFormFieldWithOutLabel(
                                                  'Old Price', oldPrice))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: TextFormFieldWithOutIcon(
                                                  'Cost per Item',
                                                  cost,
                                                  'Cost ')),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Profit",
                                                style: TextStyle(
                                                    fontSize: 22.0,
                                                    color: Color.fromARGB(
                                                        255, 107, 107, 107),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                child: Text("ETB 0",
                                                    style: TextStyle(
                                                        fontSize: 30.0,
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              )
                                            ],
                                          ))
                                        ],
                                      ),
                                      InverntoryQty(Qty),
                                    ],
                                  ),
                                ),
                              )
                            : Flexible(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Range Price",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: TextFormFieldWithOutLabel(
                                                  'From', productName)),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "-",
                                              style: TextStyle(fontSize: 30),
                                            ),
                                          ),
                                          Expanded(
                                              child: TextFormFieldWithOutLabel(
                                                  'To', productName)),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "=",
                                              style: TextStyle(fontSize: 30),
                                            ),
                                          ),
                                          Expanded(
                                              child: TextFormFieldWithOutLabel(
                                                  'Price', productName))
                                        ],
                                      ),
                                      InverntoryQty(Qty),
                                    ],
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                            onTap: () {
                              print('add product');
                            },
                            child: BlueButton(text: 'Continue'))
                      ]),
                )),
          ),
        ]),
      ),
    );
  }

  Widget InverntoryQty(int Qty) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        "Inventory (Qty)",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
      ),
      SizedBox(
        width: 15,
      ),
      Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                minus();
              });
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: CustomColors().grey),
                color: CustomColors().grey,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                  child: Text(
                "-",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )),
            ),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: CustomColors().grey),
              color: CustomColors().white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Center(
                child: Text(Qty.toString(),
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                add();
              });
            },
            child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: CustomColors().grey),
                  color: CustomColors().grey,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Text("+",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                )),
          )
        ],
      ),
    ]);
  }
}
