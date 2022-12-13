import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Providers/CollectionProvider.dart';
import 'package:ghioon_seller/Providers/RangeProvider.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/CollectionDetail/collectionDetailPage.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/addCollections.dart';
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

        // child: ListView(
        //     physics: const BouncingScrollPhysics(
        //         parent: AlwaysScrollableScrollPhysics()),
        //     children: [
        //       CollectionList(
        //           title: "BeatsStudio3",
        //           stock: "22 Available",
        //           image: 'assets/images/head.png'),
        //       CollectionList(
        //           title: "BeatsStudio3",
        //           stock: "22 Available",
        //           image: 'assets/images/head.png'),
        //       CollectionList(
        //           title: "BeatsStudio3",
        //           stock: "22 Available",
        //           image: 'assets/images/head.png')
        //     ]),

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
                            stock: collection[index].description,
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

class CollectionList extends StatelessWidget {
  const CollectionList(
      {Key? key, required this.title, required this.stock, required this.image})
      : super(key: key);

  final String title;
  final String stock;
  final List image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize().ScreenWidth(context) / 3.5,
      decoration: BoxDecoration(
        border: Border.all(
            width: 1, color: const Color.fromARGB(255, 224, 224, 224)),
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 24,
                color: CustomColors().blue,
                fontWeight: FontWeight.w700),
          ),

          leading: image[0] != ''
              ? ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: image[0],
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: Container(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.grey[300]!),
                            value: downloadProgress.progress),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                )
              : ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Icon(
                    Icons.shop,
                    size: 50,
                  ),
                ),

          // leading: image[0] != ''
          //     ? ClipRRect(
          //         borderRadius: const BorderRadius.only(
          //           topLeft: Radius.circular(8.0),
          //           topRight: Radius.circular(8.0),
          //         ),
          //         child: CachedNetworkImage(
          //           fit: BoxFit.cover,
          //           imageUrl: image[0],
          //           progressIndicatorBuilder:
          //               (context, url, downloadProgress) => Center(
          //             child: Container(
          //               height: 20,
          //               width: 20,
          //               child: CircularProgressIndicator(
          //                   valueColor: AlwaysStoppedAnimation<Color>(
          //                       Colors.grey[300]!),
          //                   value: downloadProgress.progress),
          //             ),
          //           ),
          //           errorWidget: (context, url, error) => Icon(Icons.error),
          //         ),
          //       )
          //     : SizedBox(
          //         width: 100,
          //         child: Center(
          //           child: Icon(
          //             Icons.newspaper_rounded,
          //             size: 10,
          //             color: Colors.grey[400],
          //           ),
          //         ),
          //       ),

          //Image.asset('assets/images/head.png'),

          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.penToSquare),
            iconSize: 40,
            color: CustomColors().blue,
          ),

          subtitle: Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Row(
              children: [
                Text(
                  stock,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      color: CustomColors().black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                const Text("."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
