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
              'approved': false,
              'online': true
            })
            .then((value) => print("Rgistration Info Added"))
            .catchError((error) => print("Failed to Register: $error"));
      }
    });
  }
}
