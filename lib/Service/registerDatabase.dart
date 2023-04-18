import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghioon_seller/Service/Compression/image_compression.dart';
import 'package:ghioon_seller/Service/uploadPhoto.dart';

class RegisterDatabaseService {
  var userUid;
  RegisterDatabaseService({this.userUid});
  final CollectionReference sellersCollection =
      FirebaseFirestore.instance.collection('Sellers');
  Future registerInformation(
    String sellerName,
    String businessName,
    String email,
    String businessNo,
    List<String> businessType,
    String phoneNumber,
    String region,
    String zone,
    String address,
    int ghioonId,
    List collections,
    List collection_description,
    List collection_images,
    int views,
    double rating,
    var userUid,
    String image,
  ) async {
    sellersCollection
        .where('userUid', isEqualTo: userUid)
        .get()
        .then((docs) async {
      if (docs.docs.isEmpty) {
        return await sellersCollection
            .doc(userUid)
            .set({
              'created': Timestamp.now(),
              'profileImages': [],
              'profileVideo': '',
              'sellerName': sellerName,
              'businessName': businessName,
              'email': email,
              'businessNo': businessNo,
              'businessType': businessType,
              'userUid': userUid,
              'phoneNumber': phoneNumber,
              'region':region,
              'zone':zone,
              'address': address,
              'approved': false,
              'active': false,
              'online': true,
              'views': views,
              'rating': rating,
              'GhioonId': 'GS' + ghioonId.toString(),
              'collection_images': collection_images,
              'collection_description': collection_description,
              'collections': collections,
              'image': image
            })
            .then((value) => print("Rgistration Info Added"))
            .catchError((error) => print("Failed to Register: $error"));
      }
    });
  }

  // Future edituser(
  //   String sellerName,
  //   String businessName,
  //   String email,
  //   String businessNo,
  //   String address,
  //   var userUid,
  //   String image,
  // ) async {
  //   return sellersCollection.doc(userUid).update({
  //     'sellerName': sellerName,
  //     'businessName': businessName,
  //     'email': email,
  //     'businessNo': businessNo,
  //     'address': address,
  //     'image': image
  //   });
  // }
  updateNotification(
    bool notification,
  ) async {
    return sellersCollection.doc(userUid).update({
      'notification': notification,
    });
  }

  uploadToDatabase(
    String sellerName,
    String businessName,
    String email,
    String businessNo,
    String address,
    String region,
    String zone,
    var userUid,
    String image,
  ) async {
    print("|||||||||||||||||||||||||||||||||||||||||||||||||");
    print(region);
    print(zone);

    return sellersCollection.doc(userUid).update({
      'sellerName': sellerName,
      'businessName': businessName,
      'email': email,
      'businessNo': businessNo,
      'address': address,
      'region': region,
      'zone': zone,
      'image': image
    });
  }

  editUserProfile(
    String sellerName,
    String businessName,
    String email,
    String businessNo,
    String address,
    String region,
    String zone,
    var userUid,
    String image,
  ) async {
    print("============================");
    print(region);
    print(zone);
    var uploadedPhoto = '';
    if(image != ''){
  uploadedPhoto =
        await uploadImage(await compressFile(File(image)) , userUid.toString(), 'Profile');
    }
   

    //}

    uploadToDatabase(sellerName, businessName, email, businessNo, address,region,zone,
        userUid, uploadedPhoto);
    print('done');
  }
}
