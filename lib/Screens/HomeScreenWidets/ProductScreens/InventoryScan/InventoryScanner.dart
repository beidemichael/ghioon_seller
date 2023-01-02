import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:ghioon_seller/Providers/AppState.dart';
import 'package:ghioon_seller/Shared/customColors.dart';
import 'package:provider/provider.dart';

import '../../../../Models/models.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final products = Provider.of<List<ProductBar>>(context);
    print(products.length);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Barcode/Qrcode Scanner'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.cyan,
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            alignment: Alignment.center,
            child: Stack(
              children: [
                products.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/undraw_No_data_re_kwbl.png',
                              height: MediaQuery.of(context).size.height * .3,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "Please scan Barcode to search...",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            )
                          ],
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetail(
                                            product: Product(
                                                productId:
                                                    products[index].productId,
                                                name: products[index].name,
                                                description:
                                                    products[index].description,
                                                fixed: products[index].fixed,
                                                price: products[index].price,
                                                rangeFrom:
                                                    products[index].rangeFrom,
                                                rangeTo:
                                                    products[index].rangeTo,
                                                Product_Type: products[index]
                                                    .Product_Type,
                                                Product_collection:
                                                    products[index]
                                                        .Product_collection,
                                                rating: products[index].rating,
                                                category:
                                                    products[index].category,
                                                image: products[index].image,
                                                inStock:
                                                    products[index].inStock,
                                                quantity:
                                                    products[index].quantity,
                                                documentId:
                                                    products[index].documentId,
                                                video: products[index].video,
                                                barcode:
                                                    products[index].barcode),
                                          )),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ProductList(
                                  title: products[index].name,
                                  stock: products[index].quantity.toString(),
                                  image: products[index].image,
                                  edit: true,
                                  item: products[index],
                                  index: index,
                                ),
                              ),
                            );
                          },
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
                          child: BlueButton(text: 'Search Item')),
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
