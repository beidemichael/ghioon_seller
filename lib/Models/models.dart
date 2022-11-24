class UserAuth {
  final String uid;
  UserAuth({required this.uid});
}

class UserInformation {
  String userName;
  String phoneNumber;
  String userUid;
  bool approved;
  String documentId;
  String businessCategory;
  String businessName;
  String email;
  String businessNo;

  UserInformation({
    required this.userName,
    required this.phoneNumber,
    required this.userUid,
    required this.approved,
    required this.documentId,
    required this.businessNo,
    required this.businessCategory,
    required this.businessName,
    required this.email,
  });
}

class Categories {
  String type;
  String documentId;
  Categories({
    required this.type,
    required this.documentId,
  });
}
