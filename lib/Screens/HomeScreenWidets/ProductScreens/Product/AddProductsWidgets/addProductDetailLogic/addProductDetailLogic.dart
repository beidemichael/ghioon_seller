import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ghioon_seller/Screens/components/alertDialog.dart';
import 'package:ghioon_seller/Service/Compression/image_compression.dart';
import 'package:ghioon_seller/Service/uploadPhoto.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../../../../Providers/RangeProvider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import '../../../../../../Service/Product/AddProductDatabase.dart';

class AddProductDetailLogic {
  checkImage(BuildContext context) {
    final appState = Provider.of<RangeData>(context, listen: false);
    int emptyImage = 0;
    for (var i = 0; i < appState.Images.length; i++) {
      if (appState.Images[i].photo == null) {
        emptyImage++;
        if (appState.Images.length != 1) {
          appState.Images.removeAt(i);
          appState.RefreshState();
        }
      }
    }
    if (emptyImage == appState.Images.length) {
      appState.imageFilled = false;
      appState.RefreshState();
    } else {
      appState.imageFilled = true;
      appState.RefreshState();
    }
    print('emptyImage: ' + emptyImage.toString());
    print('appStateImage: ' + appState.Images.length.toString());
    appState.RefreshState();
  }

  checkVideo(BuildContext context, bool videoSquare, bool videoLessThanSix) {
    final appState = Provider.of<RangeData>(context, listen: false);

    appState.videoLessThanSix = videoLessThanSix;

    appState.videoSquare = videoSquare;
    appState.RefreshState();
  }

  checkProductNameandDescription(BuildContext context) {
    final appState = Provider.of<RangeData>(context, listen: false);

    if (appState.productName.value.text.isNotEmpty &&
            appState.description.value.text.isNotEmpty
         &&
        // appState.selectedValue != null &&
        appState.selectedCatagoryValue != null
        ) {
      appState.productDescriptionFilled = true;
    } else {
      appState.productDescriptionFilled = false;
    }
    appState.RefreshState();
  }

  checkFixedAndRange(BuildContext context) {
    final appState = Provider.of<RangeData>(context, listen: false);

    if (appState.fixed) {
      //Fixed Product
      //Check if Fixed input fields are filled

      // if (appState.fixedPrice.value.text.isNotEmpty &&
      //     appState.oldPrice.value.text.isNotEmpty &&
      //     appState.cost.value.text.isNotEmpty) {
      Provider.of<RangeData>(context, listen: false).switchfixedFilled(true);
      appState.priceList.clear();
      appState.rangeToList.clear();
      appState.rangeFromList.clear();
      appState.priceList.add(0.0);
      appState.rangeToList.add(0);
      appState.rangeFromList.add(0);

      print("fixed product");
      // } else {
      //   Provider.of<RangeData>(context, listen: false).switchfixedFilled(false);
      // }
    } else {
      //Range Product

      //Check if Range Input fields are filled
      for (var i = 0; i < appState.Ranges.length; i++) {
        if (appState.Ranges[i].pricecontroller!.text.isNotEmpty &&
            appState.Ranges[i].tocontroller!.text.isNotEmpty &&
            appState.Ranges[i].fromcontroller!.text.isNotEmpty) {
          Provider.of<RangeData>(context, listen: false)
              .switchrangefilled(true);
          appState.priceList.clear();
          appState.rangeToList.clear();
          appState.rangeFromList.clear();
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
    appState.RefreshState();
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
        appState.selectedValue,
        appState.selectedCollectionValue,
        5,
         appState.selectedCatagoryValue,
        appState.imageList,
        appState.videoString,
        true,
        int.parse(appState.inventory.text),
        userUid);
    appState.RefreshState();
  }


  addProduct(BuildContext context) async {
    print('started uplading');
    final appState = Provider.of<RangeData>(context, listen: false);
    //appState.isLoading = true;
    final user = FirebaseAuth.instance.currentUser;
    for (var i = 0; i < appState.Images.length; i++) {
      var uploadedPhoto = await uploadImage(
          await compressFile(appState.Images[i].photo!),
          user!.uid.toString(),
          'Products');

      appState.imageList.add(uploadedPhoto.toString());
    }
    if (appState.videoSubmited) {
      var uploadedVideo =
          await uploadVideo(appState.video, user!.uid.toString(), 'Products');
      appState.videoString = uploadedVideo.toString();
    }

    uploadToDatabase(context);
    print('done');
    Navigator.pop(context);

    Navigator.pop(context);
  }
}
