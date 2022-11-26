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

class LastId {
  int lastId;

  LastId({
    required this.lastId,
  });
}

class Product {
  String productId;
  String name;
  String description;
  bool fixed;
  List<double> price;
  List<int> range;
  double rating;
  String category;
  String image;
  bool inStock;
  int quantity;

  Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.fixed,
    required this.price,
    required this.range,
    required this.rating,
    required this.category,
    required this.image,
    required this.inStock,
    required this.quantity,
  });
}

class Review {
  String productId;
  List<String> reviews;
  Review({
    required this.productId,
    required this.reviews,
  });
}
