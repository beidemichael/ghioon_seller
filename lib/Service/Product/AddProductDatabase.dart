import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddProductDatabase {
  var userUid;
  AddProductDatabase({this.userUid});
  final CollectionReference sellersProduct =
      FirebaseFirestore.instance.collection('Sellers');
  final CollectionReference product =
      FirebaseFirestore.instance.collection('Products');
  List images = [];
  Future addImage(
    String image,
    String docUid,
  ) async {
    product.doc(docUid).get().then((document) {
      images = (document.data() as dynamic)['image'] ?? '';

      images.add(image);
      return product.doc(docUid).update({
        'image': images,
      });
    });
  }

  Future deleteImage(
    String docUid,
    int index,
  ) async {
    product.doc(docUid).get().then((document) {
      images = (document.data() as dynamic)['image'] ?? '';
      images.remove(images[index]);
      return product.doc(docUid).update({
        'image': images,
      });
    });
  }

  Future uploadVideo(
    String docUid,
    String video,
  ) async {
    return product.doc(docUid).update({
      'video': video,
    });
  }

  Future editProduct(
    String docUid,
    String name,
    String description,
    List<double> price,
    List<int> rangeTo,
    List<int> rangeFrom,
    int quantity,
    String barcode,
  ) async {
    return product.doc(docUid).update({
      'created': Timestamp.now(),
      'name': name,
      'description': description,
      'price': price,
      'rangeTo': rangeTo,
      'rangeFrom': rangeFrom,
      'quantity': quantity,
      'barcode':barcode
    });
  }

  Future deleteProduct(String docUid,String userId) async {

    // Get the product document
  DocumentSnapshot productDoc = await product.doc(docUid).get();
  
  // Get the image download URL from the product document
  List  image =  productDoc.get('image');
  //String imageUrl = productDoc.get('image');
  
  // Delete the product document
  await product.doc(docUid).delete();
  
  // Delete the image from Cloud Storage
  if (image.isNotEmpty) {
    for(String imageUrl in image){
      print(imageUrl);
      // Extract the image file name from the URL
   
    //String imageName =imageUrl.split('/').last.split('?').first.split('%').last.split('%2F').last;
    String imageName =imageUrl.split('/').last.split('%2F').last.split('?').first;
    print(imageName);
    
    // Create a reference to the image file in Cloud Storage
    print('Products/$userId/$imageName');
    Reference imageRef = FirebaseStorage.instance.ref().child('Products/$userId/$imageName');

    
    // Delete the image file
    await imageRef.delete();
    print("deleted");

    }
    
  }

}

  Future addProduct(
    String name,
    String description,
    bool fixed,
    List<double> price,
    List<int> rangeTo,
    List<int> rangeFrom,
    String selectedValue,
    String selectedCatagoryValue,
    double rating,
    String category,
    List<String> image,
    String videoString,
    bool inStock,
    int quantity,
    var userUid,
  ) async {
    DocumentReference ref = await product.doc();
    return await product
        .doc(ref.id)
        .set({
          'created': Timestamp.now(),
          'productId': ref.id,
          'name': name,
          'description': description,
          'fixed': fixed,
          'price': price,
          'rangeTo': rangeTo,
          'rangeFrom': rangeFrom,
          'Product_Type': selectedValue,
          'Product_collection': selectedCatagoryValue,
          'rating': rating,
          'category': category,
          'image': image,
          'video': videoString,
          'isStock': inStock,
          'quantity': quantity,
          'userUid': userUid,
        })
        .then((value) => print("Product Info Added"))
        .catchError((error) => print("Failed to Add Product: $error"));
  }
}
