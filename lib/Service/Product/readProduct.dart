import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghioon_seller/Models/models.dart';

class ReadProductDatabaseService {
  var userUid;
  ReadProductDatabaseService({this.userUid});
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('Products');
  List<Product> _productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Product(
        productId: (doc.data() as dynamic)['productId'] ?? '',
        name: (doc.data() as dynamic)['name'] ?? '',
        description: (doc.data() as dynamic)['description'] ?? '',
        fixed: (doc.data() as dynamic)['fixed'] ?? '',
        price: (doc.data() as dynamic)['price'] ?? '',
        rangeFrom: (doc.data() as dynamic)['rangeFrom'] ?? '',
        rangeTo: (doc.data() as dynamic)['rangeTo'] ?? '',
        rating: (doc.data() as dynamic)['rating'] ?? '',
        video: (doc.data() as dynamic)['video'] ?? '',
        category: (doc.data() as dynamic)['category'] ?? '',
        image: (doc.data() as dynamic)['image'] ?? '',
        inStock: (doc.data() as dynamic)['isStock'] ?? '',
        quantity: (doc.data() as dynamic)['quantity'] ?? '',
        documentId: doc.reference.id,
      );
    }).toList();
  }

  //orders lounges stream
  Stream<List<Product>> get readProduct {
    return productCollection
        .where('userUid', isEqualTo: userUid)
        .snapshots()
        .map(_productListFromSnapshot);
  }
}
