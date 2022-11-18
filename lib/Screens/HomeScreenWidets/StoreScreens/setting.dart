import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Shared/customColors.dart';

class StoreSetting extends StatefulWidget {
  const StoreSetting({super.key});

  @override
  State<StoreSetting> createState() => _StoreSettingState();
}

class _StoreSettingState extends State<StoreSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: AppBar(
              centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text('Setting',
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
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          StoreList(FontAwesomeIcons.solidUser, 'Notification'),
          StoreList(FontAwesomeIcons.solidBell, 'Privacy and Setting'),
          StoreList(FontAwesomeIcons.lock, 'Securiy and Setting'),
          StoreList(FontAwesomeIcons.shield, 'Terms and Conditions'),
          StoreList(FontAwesomeIcons.solidCircleQuestion, 'Help and Support'),
          StoreList(FontAwesomeIcons.solidFile, 'Feedback'),
          StoreList(FontAwesomeIcons.arrowsSpin, 'Upgrade'),
          StoreList(FontAwesomeIcons.rightFromBracket, 'Logout'),
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
          border: Border.all(
              width: 1, color: const Color.fromARGB(255, 224, 224, 224)),
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
