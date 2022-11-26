import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghioon_seller/Models/models.dart';

class UserDatabaseService {
  var userUid;
  UserDatabaseService({this.userUid});
  final CollectionReference sellersCollection =
      FirebaseFirestore.instance.collection('Sellers');
  List<UserInformation> _userInfoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserInformation(
        userName: (doc.data() as dynamic)['userName'] ?? '',
        phoneNumber: (doc.data() as dynamic)['phoneNumber'] ?? '',
        userUid: (doc.data() as dynamic)['uderUid'] ?? '',
        approved: (doc.data() as dynamic)['approved'] ?? '',
        businessCategory: (doc.data() as dynamic)['businessCategory'] ?? '',
        businessName: (doc.data() as dynamic)['businessName'] ?? '',
        businessNo: (doc.data() as dynamic)['businessNo'] ?? '',
        email: (doc.data() as dynamic)['email'] ?? '',
        documentId: doc.reference.id,
      );
    }).toList();
  }

  //orders lounges stream
  Stream<List<UserInformation>> get userInfo {
    return sellersCollection
        .where('userUid', isEqualTo: userUid)
        .snapshots()
        .map(_userInfoListFromSnapshot);
  }
}
