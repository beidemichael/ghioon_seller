// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProductScreens/Product/ProductDetail/EditProductDetailWidgets.dart/4,editfixedInputField.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:ghioon_seller/Shared/language.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import '../../../../../../Providers/EditRangeProvider.dart';
import '../../../../../../Providers/language_provider.dart';
import '../../../../../../Service/Product/AddProductDatabase.dart';
import '../../../../../../Shared/customColors.dart';
import '../../../../../components/BlueButton.dart';
import '../../../../../components/textFormField.dart';
import '4,editrangeInputField.dart';

class EditProductDetail extends StatefulWidget {
  var product;
  var appState;
  EditProductDetail({super.key, required this.product, required this.appState});

  @override
  State<EditProductDetail> createState() => _EditProductDetailState();
}

class _EditProductDetailState extends State<EditProductDetail> {
  bool loading = false;
  String _scanBarcode = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.appState.productName.text = widget.product.name;
    widget.appState.description.text = widget.product.description;
  }

  Future<void> barcodeScan() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    var languageprov = Provider.of<LanguageProvider>(context);
    final appState = Provider.of<EditRangeData>(context);
    final userInfo = Provider.of<List<UserInformation>>(context);
    List<String> catagories = [];
    if (userInfo.isNotEmpty) {
      for (int i = 0; i < userInfo[0].collections.length; i++) {
        catagories.add(userInfo[0].collections[i]);
        // print(userInfo[0].collections[i]);
        // print(catagories);
        // print("33333333333333333333333333333333333333333");
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
          const SizedBox(
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
          widget.product.barcode != ''
              ? Column(
                  children: [
                    isNumeric(widget.product.barcode)
                        ? Container(
                            height: 100,
                            child: SfBarcodeGenerator(
                              value: widget.product.barcode,
                            ),
                          )
                        : Container(
                            height: 200,
                            child: SfBarcodeGenerator(
                              value: widget.product.barcode,
                              symbology: QRCode(),
                            ),
                          ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.product.barcode,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w300),
                    )
                  ],
                )
              : Container(),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
              onTap: () {
                barcodeScan();
              },
              child: BlueButton(
                  text: Language().barcode[languageprov.LanguageIndex])),
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
                    _scanBarcode);
                setState(() {
                  loading = false;
                });
                Navigator.of(context).pop();
              },
              child: loading
                  ? BlueButton(
                      text: Language().saving[languageprov.LanguageIndex])
                  : BlueButton(
                      text: Language().save[languageprov.LanguageIndex]))
        ],
      ),
    );
  }
}
