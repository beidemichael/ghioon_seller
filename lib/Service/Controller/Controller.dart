import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghioon_seller/Models/models.dart';

class ControllerDatabaseService {
  final CollectionReference controllerCollection =
      FirebaseFirestore.instance.collection('Controller');
  List<Controller> _productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Controller(
        sellerVersion: (doc.data() as dynamic)['SellerAppVersion'] ?? 1,
        documentId: doc.reference.id,
      );
    }).toList();
  }

  //orders lounges stream
  Stream<List<Controller>> get controller {
    return controllerCollection.snapshots().map(_productListFromSnapshot);
  }
}
