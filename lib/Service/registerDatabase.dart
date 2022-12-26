import 'package:cloud_firestore/cloud_firestore.dart';

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
    String businessType,
    String phoneNumber,
    String address,
    int ghioonId,
    List collections,
    List collection_description,
    List collection_images,
    var userUid,
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
              'sellerName': sellerName,
              'businessName': businessName,
              'email': email,
              'businessNo': businessNo,
              'businessType': businessType,
              'userUid': userUid,
              'phoneNumber': phoneNumber,
              'address': address,
              'approved': false,
              'active': false,
              'online': true,
              'GhioonId': 'GS' + ghioonId.toString(),
              'collection_images': collection_images,
              'collection_description': collection_description,
              'collections': collections,
            })
            .then((value) => print("Rgistration Info Added"))
            .catchError((error) => print("Failed to Register: $error"));
      }
    });
  }

  Future edituser(
    String sellerName,
    String businessName,
    String email,
    String businessNo,
    String address,
    var userUid,
  ) async {
    return sellersCollection.doc(userUid).update({
      'sellerName': sellerName,
      'businessName': businessName,
      'email': email,
      'businessNo': businessNo,
      'address': address
    });
  }
}
