import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghioon_seller/Models/models.dart';

class ReadProductDatabaseService {
  var userUid;
  var barcode;
  var category;
  ReadProductDatabaseService({this.userUid, this.barcode, this.category});
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
        viewsTime: (doc.data() as dynamic)['viewCountTime'] ?? [],
        rangeFrom: (doc.data() as dynamic)['rangeFrom'] ?? '',
        rangeTo: (doc.data() as dynamic)['rangeTo'] ?? '',
        Product_Type: (doc.data() as dynamic)['Product_Type'] ?? '',
        Product_collection: (doc.data() as dynamic)['Product_collection'] ?? '',
        rating: (doc.data() as dynamic)['rating'] ?? '',
        video: (doc.data() as dynamic)['video'] ?? '',
        category: (doc.data() as dynamic)['category'] ?? '',
        image: (doc.data() as dynamic)['image'] ?? '',
        inStock: (doc.data() as dynamic)['isStock'] ?? '',
        quantity: (doc.data() as dynamic)['quantity'] ?? '',
        barcode: (doc.data() as dynamic)['barcode'] ?? '',
         userUid: (doc.data() as dynamic)['userUid'] ?? '',
        documentId: doc.reference.id,
        viewCountTime: (doc.data() as dynamic)['viewCountTime'] ?? [],
        created:(doc.data() as dynamic)['created'] ?? Timestamp.now(),

        
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
   Stream<List<Product>> get cancelledProducts {
    return productCollection
        .where('userUid', isEqualTo: userUid)
        .where('completed', isEqualTo: true)
        .snapshots()
        .map(_productListFromSnapshot);
  }
   Stream<List<Product>> get completedProducts {
    return productCollection
        .where('userUid', isEqualTo: userUid)
        .where('completed', isEqualTo: true)
        .snapshots()
        .map(_productListFromSnapshot);
  }

 Stream<List<Product>> get readProductsUnderCatagory {
    return productCollection
        .where('category', isEqualTo: category)
        .where('userUid', isEqualTo: userUid)
        .snapshots()
        .map(_productListFromSnapshot);
  }
  List<ProductBar> _productBarListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ProductBar(
        productId: (doc.data() as dynamic)['productId'] ?? '',
        name: (doc.data() as dynamic)['name'] ?? '',
        description: (doc.data() as dynamic)['description'] ?? '',
        fixed: (doc.data() as dynamic)['fixed'] ?? '',
        price: (doc.data() as dynamic)['price'] ?? '',
        viewsTime: (doc.data() as dynamic)['viewCountTime'] ?? [],
        rangeFrom: (doc.data() as dynamic)['rangeFrom'] ?? '',
        rangeTo: (doc.data() as dynamic)['rangeTo'] ?? '',
        Product_Type: (doc.data() as dynamic)['Product_Type'] ?? '',
        Product_collection: (doc.data() as dynamic)['Product_collection'] ?? '',
        rating: (doc.data() as dynamic)['rating'] ?? '',
        video: (doc.data() as dynamic)['video'] ?? '',
        category: (doc.data() as dynamic)['category'] ?? '',
        image: (doc.data() as dynamic)['image'] ?? '',
        inStock: (doc.data() as dynamic)['isStock'] ?? '',
        quantity: (doc.data() as dynamic)['quantity'] ?? '',
        barcode: (doc.data() as dynamic)['barcode'] ?? '',
        userUid: (doc.data() as dynamic)['userUid'] ?? '',
        documentId: doc.reference.id,
        viewCountTime: (doc.data() as dynamic)['viewCountTime'] ?? [],
        created:(doc.data() as dynamic)['created'] ?? Timestamp.now(),
      );
    }).toList();
  }

  Stream<List<ProductBar>> get readProductBarCode {
    return productCollection
        .where('userUid', isEqualTo: userUid)
        .where('barcode', isEqualTo: barcode)
        .snapshots()
        .map(_productBarListFromSnapshot);
  }
}
