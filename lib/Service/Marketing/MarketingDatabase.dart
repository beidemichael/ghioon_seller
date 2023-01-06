import 'package:cloud_firestore/cloud_firestore.dart';

class AddMarketingdatabase {
  var userUid;
  AddMarketingdatabase({this.userUid});
  final CollectionReference marketing =
      FirebaseFirestore.instance.collection('Marketing');
  Future addMarketing(
    String image,
    String video,
    bool isImage,
    String sellerUid,
    String screenRealestate,
  ) async {
    DocumentReference ref = await marketing.doc();
    return await marketing
        .doc(ref.id)
        .set({
          'created': Timestamp.now(),
          'isImage': isImage,
          'screenRealestate': screenRealestate,
          'image': image,
          'video': video,
          'sellerUid': sellerUid,
          'approved':false,
        })
        .then((value) => print("Marketing Info Added"))
        .catchError((error) => print("Failed to Add Marketing: $error"));
  }
}
