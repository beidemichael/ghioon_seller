import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Models/models.dart';

class AddCollectionDatabase {
  var userUid;
  AddCollectionDatabase({this.userUid});
  final CollectionReference sellersCollection =
      FirebaseFirestore.instance.collection('Sellers');

  Future addCollection(
    String name,
    String description,
    List<String> image,
    var userUid,
    List<Product> collectionItems,
  ) async {
    sellersCollection
        .where('userUid', isEqualTo: userUid)
        .get()
        .then((docs) async {
      if (!docs.docs.isEmpty) {
        DocumentReference ref =
            sellersCollection.doc(userUid).collection('Collections').doc();
        return await sellersCollection
            .doc(userUid)
            .collection('Collections')
            .doc(ref.id)
            .set({
              'created': Timestamp.now(),
              'collectionId': ref.id,
              'name': name,
              'description': description,
              'image': image,
              'userUid': userUid,
              'collectionItems': collectionItems,
            })
            .then((value) => print("Collection  Added"))
            .catchError((error) => print("Failed to Add Collection: $error"));
      }
    });
  }
}
