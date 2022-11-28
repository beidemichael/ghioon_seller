import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Shared/customColors.dart';

import '../../../Service/auth.dart';
import '../../components/storeList.dart';

class StoreSetting extends StatefulWidget {
  const StoreSetting({super.key});

  @override
  State<StoreSetting> createState() => _StoreSettingState();
}

class _StoreSettingState extends State<StoreSetting> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                  Text('Setting',
                      style: TextStyle(
                          fontSize: 30.0,
                          color: CustomColors().white,
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
              iconTheme: IconThemeData(color: CustomColors().white)),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          StoreList(FontAwesomeIcons.solidUser, 'Notification', width),
          StoreList(FontAwesomeIcons.solidBell, 'Privacy and Setting', width),
          StoreList(FontAwesomeIcons.lock, 'Securiy and Setting', width),
          StoreList(FontAwesomeIcons.shield, 'Terms and Conditions', width),
          StoreList(
              FontAwesomeIcons.solidCircleQuestion, 'Help and Support', width),
          StoreList(FontAwesomeIcons.solidFile, 'Feedback', width),
          StoreList(FontAwesomeIcons.arrowsSpin, 'Upgrade', width),
          GestureDetector(
              onTap: () {
                AuthServices.signOut();
              },
              child: StoreList(
                  FontAwesomeIcons.rightFromBracket, 'Logout', width)),
        ],
      ),
    );
  }
}
