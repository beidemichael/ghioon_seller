import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/StoreScreens/setting.dart';

import '../../Shared/customColors.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
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
                const Text('Store',
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            // excludeHeaderSemantics: true,
            backgroundColor: CustomColors().blue,
            // automaticallyImplyLeading: false,
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.white)),
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
                    const Text('My Store',
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w700)),
                    const Text('Endale Abegazee',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w400)),
                    const Text('Id: G1547856',
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w200)),
                  ],
                ),
              ),
            ),
          ),
          StoreList(FontAwesomeIcons.solidUser, 'Customers'),
          StoreList(FontAwesomeIcons.chartPie, 'Analytics'),
          StoreList(FontAwesomeIcons.bullhorn, 'Maketing'),
          GestureDetector(
            onTap: (){
               Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StoreSetting()),
                );
            },
            child: StoreList(FontAwesomeIcons.gear, 'Setting')),
          StoreList(FontAwesomeIcons.solidCircleQuestion, 'Support'),
        ],
      ),
    );
  }

  Widget StoreList(IconData icon, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        // height: ,

        decoration: BoxDecoration(
          border:
              Border.all(width: 1, color: const Color.fromARGB(255, 224, 224, 224)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Icon(
                    icon,
                    color: CustomColors().blue,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Text(name,
                      style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              Icon(
                FontAwesomeIcons.angleRight,
                color: CustomColors().blue,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
