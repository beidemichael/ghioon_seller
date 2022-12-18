// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/AddProductsWidgets/addProductDetailWidgets/1,fixedButton.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/AddProductsWidgets/addProductDetailWidgets/1,rangeButton.dart';
import 'package:provider/provider.dart';

import '../../../../Providers/RangeProvider.dart';
import '../../../../Models/addProductmodels.dart';
import '../../../../Service/Product/AddProductDatabase.dart';
import '../../../../Service/uploadPhoto.dart';
import '../../../../Shared/customColors.dart';
import '../../../components/BlueButton.dart';
import '../../../components/alertDialog.dart';
import '../../../components/textFormField.dart';
import 'addProductDetailLogic/addProductDetailLogic.dart';
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
            children: [
              TextFormFieldProduct(
                  "Enter Product Name", appState.productName, "Product Name"),
              TextFormFieldProDescription(
                  "Description", appState.description, "Description"),
              DropdownButtonFormField(
                  decoration: InputDecoration(
                    hintText: 'Select Product Type',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: CustomColors().blue, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: CustomColors().white, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // filled: false,
                    // fillColor: Colors.blueAccent,
                  ),
                  validator: (value) =>
                      value == null ? "Select a country" : null,
                  dropdownColor: Colors.white,
                  value: appState.selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      appState.selectedValue = newValue!;
                    });
                  },
                  items: appState.dropdownItems),
              Visibility(
                visible: !appState.productDescriptionFilled,
                child: const Center(
                  child: Text(
                    "Please fill all inputs",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.red),
                  ),
                ),
              ),
              const Text(
                "Price",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Flexible(
                      child: GestureDetector(
                          onTap: () {
                            !appState.fixed
                                ? Provider.of<RangeData>(context, listen: false)
                                    .switchFixed(appState.fixed)
                                : null;
                          },
                          child: FixedButton(fixed: appState.fixed))),
                  const SizedBox(
                    width: 15,
                  ),
                  Flexible(
                      child: GestureDetector(
                          onTap: () {
                            appState.fixed
                                ? Provider.of<RangeData>(context, listen: false)
                                    .switchFixed(appState.fixed)
                                : null;
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
                    print("loading");

                    //Check if image is filled
                    AddProductDetailLogic().checkImage(context);
                    //Check if Product Name and Description is filled
                    AddProductDetailLogic()
                        .checkProductNameandDescription(context);
                    //Check if Range and Fixed fields are filled
                    AddProductDetailLogic().checkFixedAndRange(context);
                    //If All fields are filled==>
                    if (appState.fixed) {
                      if (appState.productDescriptionFilled &&
                          appState.fixedFilled &&
                          appState.videoLessThanSix &&
                          appState.videoSquare) {
                        appState.isLoading = true;
                        // AddProductDetailLogic().showDialog(context);

                        PopupDialog alert = PopupDialog(
                            "Are You Sure you want to add the product?", () {
                          print(appState.isLoading);
                          AddProductDetailLogic()
                              .addProduct(context)
                              .then((value) => appState.isLoading = false);
                        }, () {
                          Navigator.pop(context);
                        });

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
                    } else {
                      if (appState.productDescriptionFilled &&
                          appState.rangefilled &&
                          appState.videoLessThanSix &&
                          appState.videoSquare) {
                        appState.isLoading = true;
                        // AddProductDetailLogic().showDialog(context);

                        PopupDialog alert = PopupDialog(
                            "Are You Sure you want to add the product?", () {
                          print(appState.isLoading);
                          AddProductDetailLogic()
                              .addProduct(context)
                              .then((value) => appState.isLoading = false);
                        }, () {
                          Navigator.pop(context);
                        });

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
                    }

                    print("not loading");
                  },
                  child: BlueButton(text: 'Continue'))
            ]));
  }
}
