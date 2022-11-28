import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Models/addProductmodels.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/Product_components/RangeProvider.dart';
import 'package:ghioon_seller/Screens/components/BlueButton.dart';
import 'package:ghioon_seller/Screens/components/image_picker.dart';
import 'package:ghioon_seller/Service/AddProductDatabase.dart';
import 'package:ghioon_seller/Shared/customColors.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var _range = context.watch<RangeData>().Ranges;
    var _images = context.watch<RangeData>().Images;
    final appState = Provider.of<RangeData>(context);

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
                child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            shrinkWrap: true,
                            itemCount: _images.length,
                            itemBuilder: (context, index) {
                              var currentStop = _images[index];
                              return AddImage(
                                  imagefromList: _images[index].image);
                            }),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("add");
                          appState.addToImageList(ImageList());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20)),
                          ),
                          child: Icon(
                            size: 80,
                            Icons.add,
                            color: CustomColors().blue,
                          ),
                        ),
                      ),
                    ]),
              )),
          const SizedBox(height: 15),
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
                        const Text(
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
                                      offset: const Offset(
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
                            const SizedBox(
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
                                      offset: const Offset(
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
                        const SizedBox(
                          height: 10,
                        ),
                        fixed
                            ? Flexible(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Fixed Price",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: TextFormFieldWithOutLabel(
                                                  'New Price',
                                                  fixedPrice,
                                                  TextInputType.number)),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                              child: TextFormFieldWithOutLabel(
                                                  'Old Price',
                                                  oldPrice,
                                                  TextInputType.number))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: TextFormFieldWithOutIcon(
                                                  'Cost per Item',
                                                  cost,
                                                  'Cost ',
                                                  TextInputType.number)),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Profit",
                                                style: TextStyle(
                                                    fontSize: 22.0,
                                                    color: Color.fromARGB(
                                                        255, 107, 107, 107),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                child: const Text("ETB 0",
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
                                      InventoryQty(Qty),
                                    ],
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8, 0, 8),
                                        child: Row(children: [
                                          const Text(
                                            "Range Price",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              appState.addToList(Range());
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: CustomColors().white,
                                                border: Border.all(
                                                    width: 1,
                                                    color: CustomColors().blue),
                                                borderRadius:
                                                    BorderRadius.circular(35.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Icon(
                                                    FontAwesomeIcons.plus,
                                                    color: CustomColors().blue),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              appState.removeLast();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: CustomColors().blue),
                                                borderRadius:
                                                    BorderRadius.circular(35.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Icon(
                                                    FontAwesomeIcons.minus,
                                                    color: CustomColors().blue),
                                              ),
                                            ),
                                          )
                                        ]),
                                      ),
                                      ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: _range.length,
                                          itemBuilder: (context, index) {
                                            var currentStop = _range[index];
                                            return Row(
                                              children: [
                                                Expanded(
                                                    child:
                                                        TextFormFieldWithOutLabel(
                                                            'From',
                                                            _range[index]
                                                                .fromcontroller!,
                                                            TextInputType
                                                                .number)),
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "-",
                                                    style:
                                                        TextStyle(fontSize: 30),
                                                  ),
                                                ),
                                                Expanded(
                                                    child:
                                                        TextFormFieldWithOutLabel(
                                                            'To',
                                                            _range[index]
                                                                .tocontroller!,
                                                            TextInputType
                                                                .number)),
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "=",
                                                    style:
                                                        TextStyle(fontSize: 30),
                                                  ),
                                                ),
                                                Expanded(
                                                    child:
                                                        TextFormFieldWithOutLabel(
                                                            'Price',
                                                            _range[index]
                                                                .pricecontroller!,
                                                            TextInputType
                                                                .number))
                                              ],
                                            );
                                          }),
                                      InventoryQty(Qty),
                                    ],
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                            onTap: () async {
                              if (fixed) {
                                print("fixed product");
                                appState.priceList
                                    .add(double.parse(fixedPrice.text));
                                appState.rangeList
                                    .add(int.parse(Qty.toString()));
                                print(productName.text);
                                print(description.text);
                                print(appState.priceList);
                                print(appState.rangeList);
                                print(oldPrice.text);
                                print(cost.text);
                                print(Qty.toString());

                                print(appState.rangeList);

                                final user = FirebaseAuth.instance.currentUser;
                                final phoneNumber = user!.phoneNumber;
                                final userUid = user.uid;
                                await AddProductService().addProduct(
                                    productName.text,
                                    description.text,
                                    fixed,
                                    appState.priceList,
                                    appState.rangeList,
                                    3.5,
                                    'food',
                                    'asdasd/asdasd/asda',
                                    true,
                                    Qty,
                                    userUid);
                                print('done');
                              } else {
                                print('add Range product');
                                for (var i = 0; i < _range.length; i++) {
                                  appState.priceList.add(double.parse(
                                      _range[i].pricecontroller!.text));
                                  appState.rangeList.add(
                                      int.parse(_range[i].tocontroller!.text));
                                }
                                print(productName.text);
                                print(description.text);
                                print(appState.priceList);
                                print(appState.rangeList);
                                print(Qty.toString());

                                final user = FirebaseAuth.instance.currentUser;
                                final phoneNumber = user!.phoneNumber;
                                final userUid = user.uid;
                                AddProductService().addProduct(
                                    productName.text,
                                    description.text,
                                    fixed,
                                    appState.priceList,
                                    appState.rangeList,
                                    3.5,
                                    'food',
                                    'asdasd/asdasd/asda',
                                    true,
                                    Qty,
                                    userUid);
                              }
                            },
                            child: BlueButton(text: 'Continue'))
                      ]),
                )),
          ),
        ]),
      ),
    );
  }

  Widget InventoryQty(int Qty) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      const Text(
        "Inventory (Qty)",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
      ),
      const SizedBox(
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
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: const Center(
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
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Center(
                child: Text(Qty.toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold))),
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
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: const Center(
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
