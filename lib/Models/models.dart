class UserAuth {
  final String uid;
  UserAuth({required this.uid});
}

class UserInformation {
  String GhioonId;
  String userName;
  String phoneNumber;
  String userUid;
  bool approved;
  String documentId;
  List businessCategory;
  String businessName;
  String email;
  String businessNo;
  List collections;
  List collection_images;
  List collection_description;
  bool online;
  String region;
  String zone;
  String address;
  List viewsTime;
  double rating;
  String image;
  List profileImages;
  String profileVideo;

  bool notification;
  UserInformation({
    required this.GhioonId,
    required this.userName,
    required this.phoneNumber,
    required this.userUid,
    required this.approved,
    required this.documentId,
    required this.businessNo,
    required this.businessCategory,
    required this.businessName,
    required this.email,
    required this.collections,
    required this.collection_images,
    required this.collection_description,
    required this.online,
    required this.region,
    required this.zone,
    required this.address,
    required this.viewsTime,
    required this.rating,
    required this.image,
    required this.profileImages,
    required this.profileVideo,
    required this.notification,
  });
}

class Categories {
  String type;
  String documentId;
  String name;
  String image;
  Categories({
    required this.type,
    required this.documentId,
    required this.name,
    required this.image
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
  List<dynamic> price;
  List<dynamic> rangeFrom;
  List<dynamic> rangeTo;
  String Product_Type;
  String Product_collection;
  double rating;
  String category;
  List image;
  bool inStock;
  int quantity;
  String documentId;
  String video;
  String barcode;
  List viewsTime;
   String userUid;
   List viewCountTime;
   var created;

  Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.fixed,
    required this.price,
    required this.rangeFrom,
    required this.rangeTo,
    required this.Product_Type,
    required this.Product_collection,
    required this.rating,
    required this.category,
    required this.image,
    required this.inStock,
    required this.quantity,
    required this.documentId,
    required this.video,
    required this.barcode,
    required this.viewsTime,
    required this.userUid,
    required this.viewCountTime,
    required this.created
  });
}

class ProductBar {
  String productId;
  String name;
  String description;
  bool fixed;
  List<dynamic> price;
  List<dynamic> rangeFrom;
  List<dynamic> rangeTo;
  String Product_Type;
  String Product_collection;
  double rating;
  String category;
  List image;
  bool inStock;
  int quantity;
  String documentId;
  String video;
  String barcode;
    List viewsTime;
  String userUid;
  List viewCountTime;
   var created;

  ProductBar({
    required this.productId,
    required this.name,
    required this.description,
    required this.fixed,
    required this.price,
    required this.rangeFrom,
    required this.rangeTo,
    required this.Product_Type,
    required this.Product_collection,
    required this.rating,
    required this.category,
    required this.image,
    required this.inStock,
    required this.quantity,
    required this.documentId,
    required this.video,
    required this.barcode,
    required this.viewsTime,
    required this.userUid,
    required this.viewCountTime,
    required this.created
  });
}

class Collection {
  String collectionId;
  String name;
  String description;
  List image;
  String documentId;

  Collection({
    required this.collectionId,
    required this.name,
    required this.description,
    required this.image,
    required this.documentId,
  });
}

class CollectionItems {
  String productId;
  String name;
  String description;
  bool fixed;
  List<dynamic> price;
  List<dynamic> rangeFrom;
  List<dynamic> rangeTo;
  String Product_Type;
  String Product_collection;
  double rating;
  String category;
  List image;
  bool inStock;
  int quantity;
  String documentId;
  String video;
  CollectionItems({
    required this.productId,
    required this.name,
    required this.description,
    required this.fixed,
    required this.price,
    required this.rangeFrom,
    required this.rangeTo,
    required this.Product_Type,
    required this.Product_collection,
    required this.rating,
    required this.category,
    required this.image,
    required this.inStock,
    required this.quantity,
    required this.documentId,
    required this.video,
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

class Controller {
  int sellerVersion;
  String documentId;
  Controller({
    required this.sellerVersion,
    required this.documentId,
  });
}

class Orders {
  List foodName;
  List foodPrice;
  List foodQuantity;
  List foodImage;
  double subTotal;

  List isTaken;
  List isDelivered;
  List isCancelled;
  String userName;
  String userPhone;
  String userUid;
  String userPic;
  double longitude;
  double latitude;
  String information;
  var created;
  String orderNumber;
  String loungeOrderNumber;
  double serviceCharge;
  double deliveryFee;
  double tip;
  double distance;

  String documentId;
  double carrierLatitude;
  double carrierLongitude;
  String carrierName;
  String carrierImage;
  String carrierPhone;
  bool isBeingPrepared;
  List sellerId;
  bool cancelled;
  bool completed;

  Orders({
    required this.created,
    required this.deliveryFee,
    required this.distance,
    required this.foodImage,
    required this.foodName,
    required this.foodPrice,
    required this.foodQuantity,
    required this.information,
    required this.isCancelled,
    required this.isDelivered,
    required this.isTaken,
    required this.latitude,
    required this.longitude,
    required this.loungeOrderNumber,
    required this.orderNumber,
    required this.serviceCharge,
    required this.subTotal,
    required this.tip,
    required this.userName,
    required this.userPhone,
    required this.userPic,
    required this.userUid,
    required this.documentId,
    required this.carrierLatitude,
    required this.carrierLongitude,
    required this.carrierPhone,
    required this.isBeingPrepared,
    required this.carrierImage,
    required this.carrierName,
    required this.sellerId,
    required this.cancelled,
    required this.completed,
  });
}
