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
  ) async {
    sellersCollection
        .where('userUid', isEqualTo: userUid)
        .get()
        .then((docs) async {
      if (!docs.docs.isEmpty) {
        DocumentReference ref =
            sellersCollection.doc(userUid).collection('Collections').doc();
        //  print("Trying 8888888888888888888888888888888888888");
        return await sellersCollection
            .doc(userUid)
            .update({
              'collections': FieldValue.arrayUnion([name]),
              'collection_description': FieldValue.arrayUnion([description]),
              'collection_images': FieldValue.arrayUnion([image[0]]),
            })
            .then((value) => print("Collection  Added"))
            .catchError((error) => print("Failed to Add Collection: $error"));
      }
    });
  }

  Future editCollection(
    var userUid,
    String name,
    String description,
    List<double> price,
    List<int> rangeTo,
    List<int> rangeFrom,
    int quantity,
  ) async {
    return sellersCollection.doc(userUid).update({
      'created': Timestamp.now(),
      'name': name,
      'description': description,
      'price': price,
      'rangeTo': rangeTo,
      'rangeFrom': rangeFrom,
      'quantity': quantity,
    });
  }
}
