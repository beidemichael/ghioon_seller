import 'package:flutter/material.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Providers/RangeProvider.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProductScreens/Collection/CollectionDetail/collection_card.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProductScreens/Collection/cOllectionaddPro.dart';

class CollectionListGrid extends StatelessWidget {
  const CollectionListGrid({
    Key? key,
    required this.userInfo,
    required this.appState,
  }) : super(key: key);

  final List<UserInformation> userInfo;
  final RangeData appState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: userInfo[0].collections.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              appState.addSelectedCatagoryValue(userInfo[0].collections[index]);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CollectionDetailProvider(
                      collection_name: userInfo[0].collections[index],
                      collection_description:
                          userInfo[0].collection_description[index]),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CollectionList(
                  title: userInfo[0].collections[index],
                  desc: userInfo[0].collection_description[index],
                  image: userInfo[0].collection_images[index]),
            ),
          );
        },
      ),
    );
  }
}
