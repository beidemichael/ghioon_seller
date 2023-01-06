// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Providers/RangeProvider.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProductScreens/Collection/CollectionDetail/collection_card.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProductScreens/Collection/cOllectionaddPro.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProductScreens/Product/ProductDetail/productDetail.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/StoreScreens/StoreProfile/Store_profile_components/ProductForGrid.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/StoreScreens/StoreProfile/Store_profile_components/collectionListGrid.dart';
import 'package:ghioon_seller/Screens/components/emptyScreen.dart';
import 'package:ghioon_seller/Shared/constants.dart';
import 'package:ghioon_seller/Shared/customColors.dart';
import 'package:provider/provider.dart';

import '../../../../Shared/loading.dart';

class StoreProfile extends StatefulWidget {
  const StoreProfile({super.key});

  @override
  State<StoreProfile> createState() => _StoreProfileState();
}

class _StoreProfileState extends State<StoreProfile> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserInformation>>(context);
    final products = Provider.of<List<Product>>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final appState = Provider.of<RangeData>(context);
    const upperTab =
        TabBar(indicatorColor: Colors.white, indicatorWeight: 3, tabs: <Tab>[
      Tab(
        child: Text('Product',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w500)),
      ),
      Tab(
        child: Text('Collection',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w500)),
      ),
    ]);
    return DefaultTabController(
      length: 2,
      child:
      userInfo.isEmpty?Loading():
       Scaffold(
        // drawer: Drawer(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(300.0),
          child: AppBar(
              centerTitle: true,
              toolbarHeight: 250,
              title: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Column(
                            children: [
                              Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: CustomColors().darkBlue,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Icon(
                                    FontAwesomeIcons.userLarge,
                                    size: 80.0,
                                    color: Colors.white,
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                  userInfo[0].businessName, //'Endale Abegazee',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      color: CustomColors().white,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        height: 10,
                        thickness: 1,
                        color: CustomColors().white,
                      ),
                      Container(
                        height: 50,
                        width: ScreenSize().ScreenWidth(context),
                        color: CustomColors().blue,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.visibility,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      userInfo[0].views.toString(),
                                      //'25',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  ],
                                )),
                              ),
                              Expanded(
                                child: Container(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      userInfo[0].rating.toString(), //'4.5',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  ],
                                )),
                              )
                            ]),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => AccountEdit(
                    //             appState: appState,
                    //             user: userInfo[0],
                    //           )),
                    // );
                  },
                  child: Center(
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        // border: Border.all(
                        //     width: 1, color: Color.fromARGB(255, 255, 255, 255)),
                        color: CustomColors().white,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.penToSquare,
                          size: 25.0,
                          color: CustomColors().blue,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
              excludeHeaderSemantics: true,
              backgroundColor: CustomColors().blue,
              elevation: 3,
              bottom: upperTab,
              iconTheme: const IconThemeData(color: Colors.white)),
        ),
        body: TabBarView(
          children: [
            products.length == 0
                ? EmptyScreen(context, 'No Products.')
                : ProductForGrid(products: products),
            userInfo[0].collections == 0
                ? EmptyScreen(context, 'No Collections')
                : CollectionListGrid(userInfo: userInfo, appState: appState),
          ],
        ),
      ),
    );
  }
}
