import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/CollectionDetail/collection_card.dart';
import 'package:ghioon_seller/Shared/constants.dart';
import 'package:ghioon_seller/Shared/customColors.dart';
import 'package:provider/provider.dart';

class CollectionDetail extends StatefulWidget {
  Collection collection;

  CollectionDetail({super.key, required this.collection});

  @override
  State<CollectionDetail> createState() => _CollectionDetailState();
}

class _CollectionDetailState extends State<CollectionDetail> {
  @override
  Widget build(BuildContext context) {
    final collectionitems = Provider.of<List<CollectionItems>>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
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
                Text(widget.collection.name,
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
            iconTheme: IconThemeData(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 0),
        child: Column(children: [
          Text(
            widget.collection.description,
            style: TextStyle(
                fontSize: 22, fontFamily: 'INTER', fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: ScreenSize().ScreenHeight(context) * 0.06,
            width: ScreenSize().ScreenWidth(context) * 0.9,
            decoration: BoxDecoration(
              color: CustomColors().lightgrey,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
              child: Row(children: [
                Icon(Icons.search),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Add product here",
                  style: TextStyle(fontSize: 20, fontFamily: 'INTER'),
                )
              ]),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Products in Collection",
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'INTER',
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          Expanded(
            child: Container(
              // height: MediaQuery.of(context).size.height,
              child: collectionitems.length == 0
                  ? Center(
                      child: Text(
                      "No products Found",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ))
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: collectionitems.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => CollectionDetail(
                            //             collection: widget.collection.collectionItems.[index],
                            //           )),
                            // );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CollectionList(
                                title: collectionitems[index].name,
                                image: collectionitems[index].image),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ]),
      ),
    );
  }
}
