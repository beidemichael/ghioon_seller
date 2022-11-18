// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/StoreScreens/setting.dart';

import '../../Shared/customColors.dart';
import '../components/storeList.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: Container(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text('Store',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 30.0,
                        color: CustomColors().white,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            // excludeHeaderSemantics: true,
            backgroundColor: CustomColors().blue,
            // automaticallyImplyLeading: false,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            iconTheme: IconThemeData(color: CustomColors().white)),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: ,

              decoration: BoxDecoration(
                // border: Border.all(width: 1, color: Colors.black),
                color: CustomColors().blue,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text('My Store',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 30.0,
                            color: CustomColors().white,
                            fontWeight: FontWeight.w600)),
                    Text('Endale Abegazee',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18.0,
                            color: CustomColors().white,
                            fontWeight: FontWeight.w400)),
                    Text('Id: G1547856',
                        style: TextStyle(
                            fontSize: 17.0,
                            color: CustomColors().white,
                            fontWeight: FontWeight.w200)),
                  ],
                ),
              ),
            ),
          ),
          StoreList(FontAwesomeIcons.solidUser, 'Customers', width),
          StoreList(FontAwesomeIcons.chartPie, 'Analytics', width),
          StoreList(FontAwesomeIcons.bullhorn, 'Maketing', width),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StoreSetting()),
                );
              },
              child: StoreList(FontAwesomeIcons.gear, 'Setting', width)),
          StoreList(FontAwesomeIcons.solidCircleQuestion, 'Support', width),
        ],
      ),
    );
  }
}
