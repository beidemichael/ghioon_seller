import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghioon_seller/Models/models.dart';

class ReadCollectionItemsDatabaseService {
  var userUid;
  var docid;
  ReadCollectionItemsDatabaseService({this.userUid, this.docid});

  final CollectionReference sellerCollection =
      FirebaseFirestore.instance.collection('Sellers');

  List<CollectionItems> _collectionItemListFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return CollectionItems(
        name: (doc.data() as dynamic)['name'] ?? '',
        image: (doc.data() as dynamic)['image'] ?? '',
      );
    }).toList();
  }

  // Stream<List<CollectionItems>> get readCollectionItems {
  //   print(docid);
  //   print(
  //       "2345678987654567898765456789098765456789098765456789098765456789//////////////////////////////////");

  //   return sellerCollection
  //       .doc(userUid)
  //       .collection('Collections')
  //       .doc(docid)
  //       .collection('Products')
  //       .snapshots()
  //       .map(_collectionItemListFromSnapshot);
  // }

  Stream<List<CollectionItems>> get readCollectionItems {
    print(docid);
    print(
        "2345678987654567898765456789098765456789098765456789098765456789//////////////////////////////////");
    Future<List> a = sellerCollection
        .doc(userUid)
        .collection('Collections')
        .doc(docid)
        .collection('Products')
        .snapshots()
        .map(_collectionItemListFromSnapshot)
        .toList();
    print(a);
    return sellerCollection
        .doc(userUid)
        .collection('Collections')
        .doc(docid)
        .collection('Products')
        .snapshots()
        .map(_collectionItemListFromSnapshot);
  }
}
