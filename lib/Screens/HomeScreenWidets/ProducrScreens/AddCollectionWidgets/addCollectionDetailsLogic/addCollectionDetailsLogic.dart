import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ghioon_seller/Providers/CollectionProvider.dart';
import 'package:ghioon_seller/Screens/components/alertDialog.dart';
import 'package:ghioon_seller/Service/Collection/AddCollectionDatabase.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../../../../Service/uploadPhoto.dart';

class AddCollectionLogic {
  checkProductNameandDescription(BuildContext context) {
    final appState = Provider.of<CollectionData>(context, listen: false);

    if (appState.collectionName.value.text.isNotEmpty &&
        appState.collectionDescription.value.text.isNotEmpty) {
      Provider.of<CollectionData>(context, listen: false)
          .switchproductDescriptionFilled(true);
    } else {
      Provider.of<CollectionData>(context, listen: false)
          .switchproductDescriptionFilled(false);
    }
  }

  uploadToDatabase(BuildContext context) async {
    final appState = Provider.of<CollectionData>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    final userUid = user!.uid;

    await AddCollectionDatabase().addCollection(
      appState.collectionName.text,
      appState.collectionDescription.text,
      appState.imageList,
      userUid,
    );
  }

  addCollection(BuildContext context) async {
    final appState = Provider.of<CollectionData>(context, listen: false);

    final user = FirebaseAuth.instance.currentUser;

    var uploadedPhoto = await uploadImage(
        appState.collectionImage[0].photo, user!.uid.toString(), 'Collections');

    appState.imageList.add(uploadedPhoto.toString());
    //}

    uploadToDatabase(context);
    print('done');

    Navigator.pop(context);
  }
}
