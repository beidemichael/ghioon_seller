// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/AddProductsWidgets/addProductDetailWidgets/1,fixedButton.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/AddProductsWidgets/addProductDetailWidgets/1,rangeButton.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/ProductDetail/EditProduct/EditProductDetailWidgets.dart/4,editfixedInputField.dart';
import 'package:provider/provider.dart';

import '../../../../../../Providers/EditRangeProvider.dart';
import '../../../../../../Service/Product/AddProductDatabase.dart';
import '../../../../../../Shared/customColors.dart';
import '../../../../../components/BlueButton.dart';
import '../../../../../components/textFormField.dart';
import '4,editrangeInputField.dart';

class EditProductDetail extends StatefulWidget {
  Product product;
  var appState;
  EditProductDetail({super.key, required this.product, required this.appState});

  @override
  State<EditProductDetail> createState() => _EditProductDetailState();
}

class _EditProductDetailState extends State<EditProductDetail> {
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.appState.productName.text = widget.product.name;
    widget.appState.description.text = widget.product.description;
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<EditRangeData>(context);
    final userInfo = Provider.of<List<UserInformation>>(context);
    List<String> catagories = [];
    if (userInfo.isNotEmpty) {
      for (int i = 0; i < userInfo[0].collections.length; i++) {
        catagories.add(userInfo[0].collections[i]);
        print(userInfo[0].collections[i]);
        print(catagories);
        print("33333333333333333333333333333333333333333");
      }
    }

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          TextFormFieldProductInitialValue(
              appState.productName, TextInputType.text),
          TextFormFieldProDescription(
              "Description", appState.description, "Description"),
          SizedBox(
            height: 10,
          ),
          const Text(
            "Price",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          widget.product.fixed
              ? EditFixedInputField(
                  product: widget.product,
                  appState: appState,
                )
              : EditRangeInputField(product: widget.product),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
              onTap: () async {
                setState(() {
                  loading = true;
                });
                print("loading");
                final appState =
                    Provider.of<EditRangeData>(context, listen: false);
                if (widget.product.fixed) {
                  //Fixed Product

                  appState.priceList.clear();
                  appState.rangeToList.clear();
                  appState.rangeFromList.clear();
                  appState.priceList.add(double.parse(appState.cost.text));
                  appState.rangeToList.add(int.parse(appState.fixedPrice.text));
                  appState.rangeFromList.add(int.parse(appState.oldPrice.text));
                  print("fixed product");
                } else {
                  //Range Product
                  for (var i = 0; i < appState.Ranges.length; i++) {
                    appState.priceList.clear();
                    appState.rangeToList.clear();
                    appState.rangeFromList.clear();
                    for (var i = 0; i < appState.Ranges.length; i++) {
                      appState.priceList.add(double.parse(
                          appState.Ranges[i].pricecontroller!.text));
                      appState.rangeToList.add(
                          int.parse(appState.Ranges[i].tocontroller!.text));
                      appState.rangeFromList.add(
                          int.parse(appState.Ranges[i].fromcontroller!.text));
                    }

                    print('add Range product');
                  }
                }
                await AddProductDatabase().editProduct(
                  widget.product.documentId,
                  appState.productName.text,
                  appState.description.text,
                  appState.priceList,
                  appState.rangeToList,
                  appState.rangeFromList,
                  int.parse(appState.inventory.text),
                );
                setState(() {
                  loading = false;
                });
                Navigator.of(context).pop();
              },
              child: loading
                  ? BlueButton(text: 'Saving...')
                  : BlueButton(text: 'Save'))
        ],
      ),
    );
  }
}
