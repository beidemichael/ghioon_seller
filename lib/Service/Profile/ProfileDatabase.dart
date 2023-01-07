import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileDatabase {
  var userUid;
  ProfileDatabase({this.userUid});
  final CollectionReference sellers =
      FirebaseFirestore.instance.collection('Sellers');
  // final CollectionReference product =
  //     FirebaseFirestore.instance.collection('Products');
  List images = [];
  Future addImage(
    String image,
    String docUid,
  ) async {
    sellers.doc(docUid).get().then((document) {
      images = (document.data() as dynamic)['profileImages'] ?? '';

      images.add(image);
      return sellers.doc(docUid).update({
        'profileImages': images,
      });
    });
  }

  Future deleteImage(
    String docUid,
    int index,
  ) async {
    sellers.doc(docUid).get().then((document) {
      images = (document.data() as dynamic)['profileImages'] ?? '';
      images.remove(images[index]);
      return sellers.doc(docUid).update({
        'profileImages': images,
      });
    });
  }

  Future uploadVideo(
    String docUid,
    String video,
  ) async {
    return sellers.doc(docUid).update({
      'profileVideo': video,
    });
  }
}
