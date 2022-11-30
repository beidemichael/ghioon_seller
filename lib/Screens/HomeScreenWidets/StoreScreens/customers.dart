import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/StoreScreens/CustomerPages/ViewOnMap.dart';

import '../../../Shared/customColors.dart';

class Customers extends StatelessWidget {
  const Customers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text('Customers',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            container(MediaQuery.of(context).size.width, FontAwesomeIcons.users,
                'All Customers'),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewOnMap()),
                );
              },
              child: container(MediaQuery.of(context).size.width,
                  FontAwesomeIcons.mapLocationDot, 'View on Map'),
            ),
          ],
        ),
      ),
    );
  }

  Widget container(double width, IconData icon, String title) {
    return Container(
      height: width * .5,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: CustomColors().blue),
        color: CustomColors().white,
        borderRadius: BorderRadius.circular(25.0),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 2,
        //     blurRadius: 3,
        //     offset: const Offset(0, 4), // changes position of shadow
        //   ),
        // ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: CustomColors().blue,
            size: 100,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 25,
                  color: CustomColors().blue,
                  fontWeight: FontWeight.w600))
        ],
      ),
    );
  }
}
