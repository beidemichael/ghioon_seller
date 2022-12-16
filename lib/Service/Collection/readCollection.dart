import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghioon_seller/Models/models.dart';

class ReadCollectionDatabaseService {
  var userUid;
  ReadCollectionDatabaseService({this.userUid});

  final CollectionReference sellerCollection =
      FirebaseFirestore.instance.collection('Sellers');

  List<Collection> _userCollectionListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Collection(
        collectionId: (doc.data() as dynamic)['collectionId'] ?? '',
        name: (doc.data() as dynamic)['name'] ?? '',
        description: (doc.data() as dynamic)['description'] ?? '',
        image: (doc.data() as dynamic)['image'] ?? '',
        documentId: doc.reference.id,
      );
    }).toList();
  }

  Stream<List<Collection>> get readCollection {
    return sellerCollection
        .doc(userUid)
        .collection('Collections')
        .snapshots()
        .map(_userCollectionListFromSnapshot);
  }
}
