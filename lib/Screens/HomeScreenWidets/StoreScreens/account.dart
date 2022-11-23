import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/StoreScreens/AccountsWidgets/accountEdit.dart';

import '../../../Shared/customColors.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(280.0),
        child: Column(
          children: [
            AppBar(
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AccountEdit()),
                      );
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
                            FontAwesomeIcons.edit,
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
                toolbarHeight: 250,
                centerTitle: true,
                title: Row(
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
                          height: 30,
                        ),
                        Text('Endale Abegazee',
                            style: TextStyle(
                                fontSize: 25.0,
                                color: CustomColors().lightBlue,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
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
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            containerWidget('Endale Abegaze', 'Name'),
            Row(
              children: [
                Expanded(
                  child: containerWidget('Male', 'Gender'),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: containerWidget('Jan 1 2022', 'Date of birth'),
                ),
              ],
            ),
            containerWidget('Ghioon@gmail.com', 'Email'),
            containerWidget('+251912345678', 'Phone'),
            containerWidget('Jemo michael, AA', 'Address'),
          ],
        ),
      ),
    );
  }

  Widget textWidet(String text) {
    return Text(text,
        style: const TextStyle(
            fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.w500));
  }

  Widget containerWidget(String textContainer, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text,
              style: const TextStyle(
                  fontSize: 21.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500)),
          Container(
            width: MediaQuery.of(context).size.width,
            // height: ,

            decoration: BoxDecoration(
              border: Border.all(
                  width: 1, color: const Color.fromARGB(255, 207, 207, 207)),
              color: CustomColors().white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(textContainer,
                  style: const TextStyle(
                      fontSize: 21.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }
}
