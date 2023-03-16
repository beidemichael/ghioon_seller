import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghioon_seller/Models/models.dart';

class OrdersDatabaseService {
  var userUid;
  OrdersDatabaseService({this.userUid});
  final CollectionReference ordersCollection =
      FirebaseFirestore.instance.collection('Orders');
  List<Orders> _userInfoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Orders(
        documentId: doc.reference.id,
        carrierImage: (doc.data() as dynamic)['carrierImage'] ?? '',
        carrierLatitude:
            (doc.data() as dynamic)['carrierLatitude'].toDouble() ?? 0.0,
        carrierLongitude:
            (doc.data() as dynamic)['carrierLongitude'].toDouble() ?? 0.0,
        carrierName: (doc.data() as dynamic)['carrierName'] ?? '',
        carrierPhone: (doc.data() as dynamic)['carrierPhone'] ?? '',
        created: (doc.data() as dynamic)['created'] ?? Timestamp.now(),
        deliveryFee: (doc.data() as dynamic)['deliveryFee'].toDouble() ?? 0.0,
        distance: (doc.data() as dynamic)['distance'].toDouble() ?? 0.0,
        foodImage: (doc.data() as dynamic)['images'] ?? [],
        foodName: (doc.data() as dynamic)['food'] ?? [],
        foodPrice: (doc.data() as dynamic)['price'] ?? [],
        foodQuantity: (doc.data() as dynamic)['quantity'] ?? [],
        information: (doc.data() as dynamic)['information'] ?? '',
        isBeingPrepared: (doc.data() as dynamic)['isBeingPrepared'] ?? false,
        isCancelled: (doc.data() as dynamic)['isCancelled'] ?? [],
        isDelivered: (doc.data() as dynamic)['isDelivered'] ?? [],
        isTaken: (doc.data() as dynamic)['isTaken'] ?? [],
        latitude: (doc.data() as dynamic)['Latitude'].toDouble() ?? 0.0,
        longitude: (doc.data() as dynamic)['Longitude'].toDouble() ?? 0.0,
        loungeOrderNumber: (doc.data() as dynamic)['loungeOrderNumber'] ?? '',
        orderNumber: (doc.data() as dynamic)['orderCode'] ?? '',
        serviceCharge:
            (doc.data() as dynamic)['serviceCharge'].toDouble() ?? 0.0,
        subTotal: (doc.data() as dynamic)['subTotal'].toDouble() ?? 0.0,
        tip: (doc.data() as dynamic)['tip'].toDouble() ?? 0.0,
        userName: (doc.data() as dynamic)['userName'] ?? '',
        userPhone: (doc.data() as dynamic)['userPhone'] ?? '',
        userPic: (doc.data() as dynamic)['userPic'] ?? '',
        userUid: (doc.data() as dynamic)['userUid'] ?? '',
        sellerId: (doc.data() as dynamic)['sellerId'] ?? '',
        cancelled: (doc.data() as dynamic)['cancelled'] ?? false,
        completed: (doc.data() as dynamic)['completed'] ?? false,
      );
    }).toList();
  }

  //orders lounges stream
  Stream<List<Orders>> get orders {
    return ordersCollection
        .where('sellerId', arrayContains: userUid)
        .snapshots()
        .map(_userInfoListFromSnapshot);
  }

  Stream<List<Orders>> get pendingOrders {
    return ordersCollection
        .where('sellerId', arrayContains: userUid)
        .where('completed', isEqualTo: false)
        .where('cancelled', isEqualTo: false)
        .snapshots()
        .map(_userInfoListFromSnapshot);
  }

  Stream<List<Orders>> get completedOrders {
    return ordersCollection
        .where('sellerId', arrayContains: userUid)
        .where('completed', isEqualTo: true)
        .snapshots()
        .map(_userInfoListFromSnapshot);
  }

  Stream<List<Orders>> get cancelledOrders {
    return ordersCollection
        .where('sellerId', arrayContains: userUid)
        .where('cancelled', isEqualTo: true)
        .snapshots()
        .map(_userInfoListFromSnapshot);
  }
}
