import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/AddProductsWidgets/addProductDetailWidgets/1,fixedButton.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/AddProductsWidgets/addProductDetailWidgets/1,rangeButton.dart';
import 'package:provider/provider.dart';

import '../../../../Models/RangeProvider.dart';
import '../../../../Models/addProductmodels.dart';
import '../../../../Service/AddProductDatabase.dart';
import '../../../../Service/uploadPhoto.dart';
import '../../../../Shared/customColors.dart';
import '../../../components/BlueButton.dart';
import '../../../components/alertDialog.dart';
import '../../../components/textFormField.dart';
import 'addProductDetailWidgets/2,fixedInputField.dart';
import 'addProductDetailWidgets/2,rangeInputField.dart';
import 'addProductDetailWidgets/3,inventoryQty.dart';

class addProductDetail extends StatefulWidget {
  const addProductDetail({super.key});

  @override
  State<addProductDetail> createState() => _addProductDetailState();
}

class _addProductDetailState extends State<addProductDetail> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<RangeData>(context);

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          // physics: const BouncingScrollPhysics(
          //     parent: AlwaysScrollableScrollPhysics()),
          children: [
            TextFormFieldProduct(
                "Enter Product Name", appState.productName, "Product Name"),
            TextFormFieldProDescription(
                "Description", appState.description, "Description"),
            const Text(
              "Price",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Flexible(
                    child: GestureDetector(
                        onTap: () {
                          Provider.of<RangeData>(context, listen: false)
                              .switchFixed(appState.fixed);
                        },
                        child: FixedButton(fixed: appState.fixed))),
                const SizedBox(
                  width: 15,
                ),
                Flexible(
                    child: GestureDetector(
                        onTap: () {
                          Provider.of<RangeData>(context, listen: false)
                              .switchFixed(appState.fixed);
                        },
                        child: RangeButton(fixed: appState.fixed))),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            appState.fixed
                ? const FixedInputField()
                : const RangeInputField(),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: () async {
                  if (appState.fixed) {
                    if (appState.productName.value.text.isNotEmpty &&
                        appState.description.value.text.isNotEmpty &&
                        appState.fixedPrice.value.text.isNotEmpty &&
                        appState.oldPrice.value.text.isNotEmpty &&
                        appState.cost.value.text.isNotEmpty) {
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
                              const Duration(milliseconds: 400),
                          pageBuilder: (_, __, ___) {
                            return const Center(
                              child: SpinKitFadingCube(
                                color: Colors.white,
                                size: 50.0,
                              ),
                            );
                          },
                        );

                        final user = FirebaseAuth.instance.currentUser;
                        print("fixed product");
                        appState.priceList
                            .add(double.parse(appState.fixedPrice.text));
                        appState.rangeList.add(
                            int.parse(appState.inventory.text.toString()));
                        for (var i = 0; i < appState.Images.length; i++) {
                          var uploadedPhoto = await uploadImage(
                              appState.Images[i].photo, user!.uid.toString());

                          appState.imageList.add(uploadedPhoto.toString());
                        }

                        print(appState.productName.text);
                        print(appState.description.text);
                        print(appState.priceList);
                        print(appState.rangeList);
                        print(appState.oldPrice.text);
                        print(appState.cost.text);
                        print(appState.inventory.text.toString());
                        print(appState.imageList);
                        print(appState.rangeList);

                        final userUid = user!.uid;
                        await AddProductService().addProduct(
                            appState.productName.text,
                            appState.description.text,
                            appState.fixed,
                            appState.priceList,
                            appState.rangeList,
                            5,
                            'food',
                            appState.imageList,
                            true,
                            int.parse(appState.inventory.text),
                            userUid);
                        print('done');
                        Navigator.pop(context);
                        // ignore: use_build_context_synchronously

                        buildShowDoneDialog(
                            context, 'Traffic', "Report Sumbited", () {
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
                    if (appState.productName.value.text.isNotEmpty &&
                        appState.description.value.text.isNotEmpty) {
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
                                  .withOpacity(0.6), // Background color
                              barrierDismissible: false,
                              barrierLabel: 'Dialog',
                              transitionDuration:
                                  const Duration(milliseconds: 400),
                              pageBuilder: (_, __, ___) {
                                return const Center(
                                  child: SpinKitFadingCube(
                                    color: Colors.white,
                                    size: 50.0,
                                  ),
                                );
                              },
                            );
                            final user = FirebaseAuth.instance.currentUser;
                            print('add Range product');
                            for (var i = 0; i < appState.Ranges.length; i++) {
                              appState.priceList.add(double.parse(
                                  appState.Ranges[i].pricecontroller!.text));
                              appState.rangeList.add(int.parse(
                                  appState.Ranges[i].tocontroller!.text));
                            }

                            for (var i = 0; i < appState.Images.length; i++) {
                              var uploadedPhoto = await uploadImage(
                                  appState.Images[i].photo,
                                  user!.uid.toString());

                              appState.imageList
                                  .add(uploadedPhoto.toString());
                            }
                            print(appState.productName.text);
                            print(appState.description.text);
                            print(appState.priceList);
                            print(appState.rangeList);
                            print(appState.inventory.text.toString());
                            print(appState.imageList);

                            final userUid = user!.uid;
                            AddProductService().addProduct(
                                appState.productName.text,
                                appState.description.text,
                                appState.fixed,
                                appState.priceList,
                                appState.rangeList,
                                5,
                                'food',
                                appState.imageList,
                                true,
                                int.parse(appState.inventory.text),
                                userUid);
                            print('done');
                            Navigator.pop(context);
                            // ignore: use_build_context_synchronously
                            buildShowDoneDialog(
                                context, 'Ghioon', "Product Added", () {
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
    );
  }
}
