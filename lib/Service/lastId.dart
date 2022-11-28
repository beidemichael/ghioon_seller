import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:ghioon_seller/Models/models.dart';

class LastIdService {
  var userUid;

  LastIdService({this.userUid});
  final CollectionReference lastIdCollection =
      FirebaseFirestore.instance.collection('SellerID');

  List<LastId> _lastIDFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return LastId(
        lastId: (doc.data() as dynamic)['ID'] ?? '',
      );
    }).toList();
  }

  Stream<List<LastId>> get lastId {
    return lastIdCollection.snapshots().handleError((onError) {
      print(onError.toString());
    }).map(_lastIDFromSnapshot);
  }

  Future updateLastID(int ghioonId) async {
    await lastIdCollection.doc('LastID').set({
      'ID': ghioonId,
    });
  }
}
