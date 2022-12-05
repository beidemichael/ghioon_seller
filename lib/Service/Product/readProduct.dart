import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghioon_seller/Models/models.dart';

class ReadProductDatabaseService {
  var userUid;
  ReadProductDatabaseService({this.userUid});
  final CollectionReference sellersCollection =
      FirebaseFirestore.instance.collection('Sellers');
  List<Product> _userInfoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Product(
        productId : (doc.data() as dynamic)['email'] ?? '',
        name: (doc.data() as dynamic)['email'] ?? '',
        description: (doc.data() as dynamic)['email'] ?? '',
        fixed: (doc.data() as dynamic)['email'] ?? '',
        price: (doc.data() as dynamic)['email'] ?? '',
        range: (doc.data() as dynamic)['email'] ?? '',
        rating: (doc.data() as dynamic)['email'] ?? '',
        category: (doc.data() as dynamic)['email'] ?? '',
        image: (doc.data() as dynamic)['email'] ?? '',
        inStock: (doc.data() as dynamic)['email'] ?? '',
        quantity: (doc.data() as dynamic)['email'] ?? '',
        documentId: doc.reference.id,
      );
    }).toList();
  }

  //orders lounges stream
  Stream<List<Product>> get readProduct {
    return sellersCollection
        .where('userUid', isEqualTo: userUid)
        .snapshots()
        .map(_userInfoListFromSnapshot);
  }
}
