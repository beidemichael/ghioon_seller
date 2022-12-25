import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghioon_seller/Providers/CollectionProvider.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProductScreens/Collection/AddCollectionWidgets/addCollectionDetailContainer.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProductScreens/Collection/AddCollectionWidgets/addImageContainer.dart';
import 'package:ghioon_seller/Screens/components/loadingWidget.dart';
import 'package:ghioon_seller/Shared/customColors.dart';
import 'package:provider/provider.dart';

class AddCollections extends StatefulWidget {
  const AddCollections({super.key});

  @override
  State<AddCollections> createState() => _AddCollectionsState();
}

class _AddCollectionsState extends State<AddCollections> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final appState = Provider.of<CollectionData>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text('Add Collection',
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            backgroundColor: CustomColors().blue,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            iconTheme: IconThemeData(color: CustomColors().white)),
      ),
      body: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    const SizedBox(height: 20),
                    Container(
                        height: height / 7,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(255, 207, 207, 207)),
                          color: CustomColors().white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: const AddCollectionImageContainer()),
                    const SizedBox(height: 15),
                    addCollectionDetail(),
                    const SizedBox(height: 15),
                  ])),
          Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Visibility(
                visible: appState.isLoading,
                child: LoadingWidget(
                    height: height, message: "Adding Collection . . ."),
              ))
        ],
      ),
    );
  }
}
