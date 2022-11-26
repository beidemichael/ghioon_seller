import 'package:cloud_firestore/cloud_firestore.dart';

class AddProductService {
  var userUid;
  AddProductService({this.userUid});
  final CollectionReference sellersCollection =
      FirebaseFirestore.instance.collection('Sellers');

  Future registerInformation(
    String productId,
    String name,
    String description,
    bool fixed,
    List<double> price,
    List<int> range,
    double rating,
    String category,
    String image,
    bool inStock,
    int quantity,
    var userUid,
  ) async {
    sellersCollection
        .where('userUid', isEqualTo: userUid)
        .get()
        .then((docs) async {
      if (docs.docs.isEmpty) {
        DocumentReference ref =
            await sellersCollection.doc(userUid).collection('Products').doc();
        return await sellersCollection
            .doc(userUid)
            .collection('Products')
            .doc(ref.id)
            .set({
              'created': Timestamp.now(),
              'productId': productId,
              'name': name,
              'description': description,
              'fixed': fixed,
              'price': price,
              'rating': rating,
              'category': category,
              'image': false,
              'isStock': inStock,
              'quantity': quantity,
              'userUid': userUid,
            })
            .then((value) => print("Product Info Added"))
            .catchError((error) => print("Failed to Add Product: $error"));
      }
    });
  }
}
