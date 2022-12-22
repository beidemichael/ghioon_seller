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
        GhioonId: (doc.data() as dynamic)['GhioonId'] ?? '',
        userName: (doc.data() as dynamic)['sellerName'] ?? '',
        phoneNumber: (doc.data() as dynamic)['phoneNumber'] ?? '',
        userUid: (doc.data() as dynamic)['userUid'] ?? '',
        approved: (doc.data() as dynamic)['approved'] ?? '',
        businessCategory: (doc.data() as dynamic)['businessCategory'] ?? '',
        businessName: (doc.data() as dynamic)['businessName'] ?? '',
        businessNo: (doc.data() as dynamic)['businessNo'] ?? '',
        email: (doc.data() as dynamic)['email'] ?? '',
        documentId: doc.reference.id,
        online: (doc.data() as dynamic)['online'] ?? '',
        collections: (doc.data() as dynamic)['collections'] ?? '',
        collection_description:
            (doc.data() as dynamic)['collection_description'] ?? '',
        collection_images: (doc.data() as dynamic)['collection_images'] ?? '',
      );
    }).toList();
  }

  //orders lounges stream
  Stream<List<UserInformation>> get userInfo {
    print(userUid);
    print(
        "5555555555555555555555555555555555555555555555555555555555555555555555555555555555555");
    return sellersCollection
        .where('userUid', isEqualTo: userUid)
        .snapshots()
        .map(_userInfoListFromSnapshot);
  }
}
