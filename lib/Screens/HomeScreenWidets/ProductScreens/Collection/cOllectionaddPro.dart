import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Service/Product/readProduct.dart';

import 'package:ghioon_seller/Service/userDatabase.dart';
import 'package:provider/provider.dart';

import '../../../../Providers/RangeProvider.dart';
import '../../../../Service/Collection/readCollectionItems.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProductScreens/Collection/CollectionDetail/collectionDetailPage.dart';

class CollectionDetailProvider extends StatefulWidget {
  String collection_name;
  String collection_description;

  CollectionDetailProvider(
      {super.key,
      required this.collection_name,
       this.collection_description = ''});

  @override
  State<CollectionDetailProvider> createState() =>
      _CollectionDetailProviderState();
}

class _CollectionDetailProviderState extends State<CollectionDetailProvider> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<RangeData>(context);

    return StreamProvider<List<Product>>.value(
        initialData: [],
        value: ReadProductDatabaseService(
                userUid: FirebaseAuth.instance.currentUser!.uid,
                category: appState.selectedCatagoryValue)
            .readProductsUnderCatagory,
        child: CollectionDetail(
            collection_name: widget.collection_name,
            collection_description: widget.collection_description));
  }
}
