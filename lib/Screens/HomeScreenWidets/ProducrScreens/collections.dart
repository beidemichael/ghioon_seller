import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Providers/CollectionProvider.dart';
import 'package:ghioon_seller/Providers/RangeProvider.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/CollectionDetail/collectionDetailPage.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/CollectionDetail/collection_card.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/addCollections.dart';
import 'package:ghioon_seller/Service/Collection/readCollectionItems.dart';
import 'package:ghioon_seller/Shared/customColors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Shared/constants.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/addProduct.dart';
import 'package:provider/provider.dart';
//import 'ProductDetail/productCard.dart';

class Collections extends StatefulWidget {
  const Collections({super.key});

  @override
  State<Collections> createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> {
  @override
  Widget build(BuildContext context) {
    final collectionState = Provider.of<CollectionData>(context);
    final collection = Provider.of<List<Collection>>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
            actions: [
              SizedBox(
                width: 20,
              )
            ],
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text('Collections',
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            // excludeHeaderSemantics: true,
            backgroundColor: CustomColors().blue,
            // automaticallyImplyLeading: false,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 0),
        child: collection.length == 0
            ? Center(
                child: Text(
                "No collections Found",
                style: TextStyle(
                  fontSize: 25,
                ),
              ))
            : Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: collection.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        ReadCollectionItemsDatabaseService(
                          userUid: FirebaseAuth.instance.currentUser!.uid,
                          docid: collection[index].collectionId,
                        ).readCollectionItems;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CollectionDetail(
                                    collection: collection[index],
                                  )),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CollectionList(
                            title: collection[index].name,
                            desc: collection[index].description,
                            image: collection[index].image),
                      ),
                    );
                  },
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors().blue,
        onPressed: () {
          collectionState.addinitCollectionImages();
          collectionState.removeallimages();
          collectionState.cleanallcontrollers();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCollections()),
          );
        },
        child: Center(
          child: Icon(
            FontAwesomeIcons.plus,
            size: 25.0,
            color: CustomColors().white,
          ),
        ),
      ),
    );
  }
}
