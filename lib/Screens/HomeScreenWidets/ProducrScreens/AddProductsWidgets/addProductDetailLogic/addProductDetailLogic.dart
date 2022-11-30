import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ghioon_seller/Screens/components/alertDialog.dart';
import 'package:ghioon_seller/Service/uploadPhoto.dart';
import 'package:provider/provider.dart';

import '../../../../../Providers/RangeProvider.dart';
import '../../../../../Service/AddProductDatabase.dart';

class AddProductDetailLogic {
  checkProductNameandDescription(BuildContext context) {
    final appState = Provider.of<RangeData>(context, listen: false);

    if (appState.productName.value.text.isNotEmpty &&
        appState.description.value.text.isNotEmpty) {
      Provider.of<RangeData>(context, listen: false)
          .switchproductDescriptionFilled(true);
    } else {
      Provider.of<RangeData>(context, listen: false)
          .switchproductDescriptionFilled(false);
    }
  }

  checkFixedAndRange(BuildContext context) {
    final appState = Provider.of<RangeData>(context, listen: false);

    if (appState.fixed) {
      //Fixed Product
      //Check if Fixed input fields are filled
      if (appState.fixedPrice.value.text.isNotEmpty &&
          appState.oldPrice.value.text.isNotEmpty &&
          appState.cost.value.text.isNotEmpty) {
        Provider.of<RangeData>(context, listen: false).switchfixedFilled(true);
        appState.priceList.add(double.parse(appState.fixedPrice.text));
        print("fixed product");
      } else {
        Provider.of<RangeData>(context, listen: false).switchfixedFilled(false);
      }
    } else {
      //Range Product

      //Check if Range Input fields are filled
      for (var i = 0; i < appState.Ranges.length; i++) {
        if (appState.Ranges[i].pricecontroller!.text.isNotEmpty &&
            appState.Ranges[i].tocontroller!.text.isNotEmpty &&
            appState.Ranges[i].fromcontroller!.text.isNotEmpty) {
          Provider.of<RangeData>(context, listen: false)
              .switchrangefilled(true);
          for (var i = 0; i < appState.Ranges.length; i++) {
            appState.priceList
                .add(double.parse(appState.Ranges[i].pricecontroller!.text));
            appState.rangeToList
                .add(int.parse(appState.Ranges[i].tocontroller!.text));
            appState.rangeFromList
                .add(int.parse(appState.Ranges[i].fromcontroller!.text));
          }
          print('add Range product');
        } else {
          Provider.of<RangeData>(context, listen: false)
              .switchrangefilled(false);
        }
      }
    }
  }

  uploadToDatabase(BuildContext context) async {
    final appState = Provider.of<RangeData>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    final userUid = user!.uid;

    await AddProductDatabase().addProduct(
        appState.productName.text,
        appState.description.text,
        appState.fixed,
        appState.priceList,
        appState.rangeToList,
        appState.rangeFromList,
        5,
        'food',
        appState.imageList,
        true,
        int.parse(appState.inventory.text),
        userUid);
  }

  showDialog(BuildContext context) async {
    final appState = Provider.of<RangeData>(context, listen: false);
    buildShowDialog(
        context, 'Ghioon', "Are you sure you want to add the product?",
        () async {
      //yesCallback
      Navigator.pop(context);

      showGeneralDialog(
        context: context,
        barrierColor: Colors.black12.withOpacity(0.6), // Background color
        barrierDismissible: false,
        barrierLabel: 'Dialog',
        transitionDuration: const Duration(milliseconds: 400),
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

      for (var i = 0; i < appState.Images.length; i++) {
        var uploadedPhoto =
            await uploadImage(appState.Images[i].photo, user!.uid.toString());

        appState.imageList.add(uploadedPhoto.toString());
      }

      uploadToDatabase(context);
      print('done');
      Navigator.pop(context);

      buildShowDoneDialog(context, 'Ghioon', "Product Added", () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }, () {
      // NoCallBack
      Navigator.of(context).pop();
    });
  }
}
