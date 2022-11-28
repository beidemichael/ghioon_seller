import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Models/addProductmodels.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/Product_components/RangeProvider.dart';
import 'package:ghioon_seller/Screens/components/BlueButton.dart';
import 'package:ghioon_seller/Screens/components/alert.dart';
import 'package:ghioon_seller/Screens/components/alertDialog.dart';
import 'package:ghioon_seller/Screens/components/image_picker.dart';
import 'package:ghioon_seller/Service/AddProductDatabase.dart';
import 'package:ghioon_seller/Service/uploadPhoto.dart';
import 'package:ghioon_seller/Shared/customColors.dart';
import 'package:image_picker/image_picker.dart';
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
  final inventory = TextEditingController();

  bool fixed = true;

  File? image;

  final ImagePicker _picker = ImagePicker();
  add() {
    //Qty = Qty + 1;
    inventory.text = (int.parse(inventory.text) + 1).toString();
    print(inventory.text);
  }

  minus() {
    //  Qty > 0 ? Qty = Qty - 1 : Qty = 0;
    int.parse(inventory.text) > 1
        ? inventory.text = (int.parse(inventory.text) - 1).toString()
        : inventory.text = '1';
  }

  @override
  void initState() {
    super.initState();
    inventory.text = "1";
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var _range = context.watch<RangeData>().Ranges;
    var _images = context.watch<RangeData>().Images;
    final appState = Provider.of<RangeData>(context);

    Future pickImage(ImageSource source, int index) async {
      final image = await _picker.pickImage(
        source: source,
      );

      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        _images[index].photo = imageTemporary;
      });
    }

    removeImage(int index) {
      setState(() {
        _images[index].photo = null;
      });
    }

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
                              var currentImage = _images[index];
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: SizedBox(
                                    height: 115,
                                    width: 115,
                                    child: GestureDetector(
                                      onTap: () {
                                        print('Change image');
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                  'Choose option',
                                                  style: TextStyle(
                                                      color:
                                                          CustomColors().blue,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: [
                                                      alertLists(
                                                          icon: Icons.camera,
                                                          title: 'Camera',
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                            pickImage(
                                                                ImageSource
                                                                    .camera,
                                                                index);
                                                          }),
                                                      alertLists(
                                                          icon: Icons
                                                              .photo_library,
                                                          title: 'Gallary',
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                            pickImage(
                                                                ImageSource
                                                                    .gallery,
                                                                index);
                                                          }),
                                                      alertLists(
                                                          icon: Icons.delete,
                                                          title: 'Remove',
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                            removeImage(index);
                                                          })
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                20.0), //or 15.0
                                            child: Container(
                                              child: _images[index].photo !=
                                                      null
                                                  ? Image.file(
                                                      _images[index].photo!,
                                                      height: double.infinity,
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Icon(
                                                      size: 80,
                                                      Icons.add_a_photo,
                                                      color:
                                                          CustomColors().blue,
                                                    ),
                                              // Image(image: AssetImage('assets/images/ima.png')),
                                            ),
                                          ),
                                          Positioned(
                                              top: -5,
                                              right: 0,
                                              child: SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child: FloatingActionButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            side: BorderSide(
                                                                color: Colors
                                                                    .white)),
                                                    backgroundColor:
                                                        Color(0xFFF5F6F9),
                                                    onPressed: () {
                                                      appState.removeImage(
                                                          _images[index]);
                                                    },
                                                    child: Icon(
                                                      Icons.delete,
                                                      color:
                                                          CustomColors().blue,
                                                    ),
                                                  )))
                                        ],
                                      ),
                                    )),
                              );
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
                            ? Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  fontWeight: FontWeight.w500),
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
                                    InventoryQty(),
                                  ],
                                ),
                              )
                            : Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 8, 0, 8),
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
                                              child: Icon(FontAwesomeIcons.plus,
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
                                                          TextInputType.number))
                                            ],
                                          );
                                        }),
                                    InventoryQty(),
                                  ],
                                ),
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                            onTap: () async {
                              if (fixed) {
                                if (productName.value.text.isNotEmpty &&
                                    description.value.text.isNotEmpty &&
                                    fixedPrice.value.text.isNotEmpty &&
                                    oldPrice.value.text.isNotEmpty &&
                                    cost.value.text.isNotEmpty) {
                                  // ignore: prefer_function_declarations_over_variables

                                  buildShowDialog(context, 'Ghioon',
                                      "Are you sure you want to add the product?",
                                      () async {
                                    Navigator.pop(context);

                                    showGeneralDialog(
                                      context: context,
                                      barrierColor: Colors.black12
                                          .withOpacity(0.6), // Background color
                                      barrierDismissible: false,
                                      barrierLabel: 'Dialog',
                                      transitionDuration:
                                          Duration(milliseconds: 400),
                                      pageBuilder: (_, __, ___) {
                                        return Center(
                                          child: SpinKitFadingCube(
                                            color: Colors.white,
                                            size: 50.0,
                                          ),
                                        );
                                      },
                                    );

                                    final user =
                                        FirebaseAuth.instance.currentUser;
                                    print("fixed product");
                                    appState.priceList
                                        .add(double.parse(fixedPrice.text));
                                    appState.rangeList.add(
                                        int.parse(inventory.text.toString()));
                                    for (var i = 0; i < _images.length; i++) {
                                      var uploadedPhoto = await uploadImage(
                                          _images[i].photo,
                                          user!.uid.toString());

                                      appState.imageList
                                          .add(uploadedPhoto.toString());
                                    }

                                    print(productName.text);
                                    print(description.text);
                                    print(appState.priceList);
                                    print(appState.rangeList);
                                    print(oldPrice.text);
                                    print(cost.text);
                                    print(inventory.text.toString());
                                    print(appState.imageList);
                                    print(appState.rangeList);

                                    final userUid = user!.uid;
                                    await AddProductService().addProduct(
                                        productName.text,
                                        description.text,
                                        fixed,
                                        appState.priceList,
                                        appState.rangeList,
                                        5,
                                        'food',
                                        appState.imageList,
                                        true,
                                        int.parse(inventory.text),
                                        userUid);
                                    print('done');
                                    Navigator.pop(context);
                                    // ignore: use_build_context_synchronously

                                    buildShowDoneDialog(
                                        context, 'Traffic', "Report Sumbited",
                                        () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    });
                                  }, //yesCallback

                                      () {
                                    // NoCallBack
                                    Navigator.pop(context);
                                  });
                                } else {
                                  print("Fill all spaces");
                                }
                              } else {
                                if (productName.value.text.isNotEmpty &&
                                    description.value.text.isNotEmpty) {
                                  // ignore: prefer_function_declarations_over_variables

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return PopupDialog(
                                          "Are You sure You want to add the Product?",
                                          () async {
                                        //yes callback
                                        showGeneralDialog(
                                          context: context,
                                          barrierColor: Colors.black12
                                              .withOpacity(
                                                  0.6), // Background color
                                          barrierDismissible: false,
                                          barrierLabel: 'Dialog',
                                          transitionDuration:
                                              Duration(milliseconds: 400),
                                          pageBuilder: (_, __, ___) {
                                            return Center(
                                              child: SpinKitFadingCube(
                                                color: Colors.white,
                                                size: 50.0,
                                              ),
                                            );
                                          },
                                        );
                                        final user =
                                            FirebaseAuth.instance.currentUser;
                                        print('add Range product');
                                        for (var i = 0;
                                            i < _range.length;
                                            i++) {
                                          appState.priceList.add(double.parse(
                                              _range[i].pricecontroller!.text));
                                          appState.rangeList.add(int.parse(
                                              _range[i].tocontroller!.text));
                                        }

                                        for (var i = 0;
                                            i < _images.length;
                                            i++) {
                                          var uploadedPhoto = await uploadImage(
                                              _images[i].photo,
                                              user!.uid.toString());

                                          appState.imageList
                                              .add(uploadedPhoto.toString());
                                        }
                                        print(productName.text);
                                        print(description.text);
                                        print(appState.priceList);
                                        print(appState.rangeList);
                                        print(inventory.text.toString());
                                        print(appState.imageList);

                                        final userUid = user!.uid;
                                        AddProductService().addProduct(
                                            productName.text,
                                            description.text,
                                            fixed,
                                            appState.priceList,
                                            appState.rangeList,
                                            5,
                                            'food',
                                            appState.imageList,
                                            true,
                                            int.parse(inventory.text),
                                            userUid);
                                        print('done');
                                        Navigator.pop(context);
                                        // ignore: use_build_context_synchronously
                                        buildShowDoneDialog(
                                            context, 'Ghioon', "Product Added",
                                            () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        });
                                      }, () {
                                        //No callback
                                        Navigator.of(context).pop();
                                      });
                                      ;
                                    },
                                  );
                                } else {
                                  print("Fill all spaces");
                                }
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

  Widget InventoryQty() {
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
            width: 80,
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
                child: TextField(
                    keyboardType: TextInputType.number,
                    controller: inventory,
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
