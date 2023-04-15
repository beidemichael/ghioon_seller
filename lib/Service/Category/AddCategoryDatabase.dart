import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Models/models.dart';

class AddCategoryDatabase {
  var userUid;
  AddCategoryDatabase({this.userUid});
  final CollectionReference sellersCategory =
      FirebaseFirestore.instance.collection('Sellers');

  Future addCategory(
    List<String> bussinessCategories,
  
    var userUid,
  ) async {
    sellersCategory
        .where('userUid', isEqualTo: userUid)
        .get()
        .then((docs) async {
      if (!docs.docs.isEmpty) {
        for (String value in bussinessCategories){
           return await sellersCategory
            .doc(userUid)
            .update({
              'businessType': FieldValue.arrayUnion([value]),
            })
            .then((value) => print("Category  Added"))
            .catchError((error) => print("Failed to Add Category: $error"));

        }
    
       
      }
    });
  }


  Future removeCategory(
  String name,
  var userUid,
) async {
  sellersCategory
      .where('userUid', isEqualTo: userUid)
      .get()
      .then((docs) async {
    if (!docs.docs.isEmpty) {
      return await sellersCategory
          .doc(userUid)
          .update({
            'businessType': FieldValue.arrayRemove([name]),
          })
          .then((value) => print("Category Removed"))
          .catchError((error) => print("Failed to Remove Category: $error"));
    }
  });
}


}
