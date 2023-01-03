import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:ghioon_seller/Providers/AppState.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProductScreens/InventoryScan/DialogScannedProductsList.dart';
import 'package:ghioon_seller/Shared/customColors.dart';
import 'package:provider/provider.dart';

import '../../../../Models/models.dart';
import '../../../../Service/Product/readProduct.dart';
import '../../../components/BlueButton.dart';
import '../Product/ProductDetail/productCard.dart';
import '../Product/ProductDetail/productDetail.dart';

class BarcodeScannerDemo extends StatefulWidget {
  const BarcodeScannerDemo({Key? key}) : super(key: key);
  @override
  _BarcodeScannerDemoState createState() => _BarcodeScannerDemoState();
}

class _BarcodeScannerDemoState extends State<BarcodeScannerDemo> {
  String _scanBarcode = 'Unknown';

  /// For Continuous scan
  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> barcodeScan() async {
    final appState = Provider.of<AppState>(context, listen: false);
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
      appState.barCode = _scanBarcode;
      Provider.of<AppState>(context, listen: false).refresh();
    });

    _scannedProductsDialog(context);
  }

  _scannedProductsDialog(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    ScannedProducts alert = ScannedProducts();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StreamProvider<List<ProductBar>>.value(
          initialData: [],
          value: ReadProductDatabaseService(
                  userUid: FirebaseAuth.instance.currentUser!.uid,
                  barcode: _scanBarcode)
              .readProductBarCode,
          child: alert,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text('Barcode/Qrcode Scanner',
                    style: TextStyle(
                        fontSize: 25.0,
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
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/undraw_Landscape_photographer_156c.png',
                        height: MediaQuery.of(context).size.height * .5,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Please scan Barcode/QRcode",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      )
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            barcodeScan();
                            Provider.of<AppState>(context, listen: false)
                                .refresh();
                            setState(() {
                              _scanBarcode = _scanBarcode;
                            });
                          },
                          child: BlueButton(text: 'SCAN')),
                      const SizedBox(
                        height: 45,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
