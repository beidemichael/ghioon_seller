import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Screens/components/textFormField.dart';

import '../../../../Shared/customColors.dart';

class AccountEdit extends StatefulWidget {
  const AccountEdit({super.key});

  @override
  State<AccountEdit> createState() => _AccountEditState();
}

class _AccountEditState extends State<AccountEdit> {
  final fullName = TextEditingController();
  final gender = TextEditingController();

  final dateOfBirth = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    fullName.dispose();
    gender.dispose();
    dateOfBirth.dispose();
    email.dispose();
    phone.dispose();
    address.dispose();
  }

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
                      Navigator.of(context).pop();
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
                            FontAwesomeIcons.save,
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
            TextFormFieldWithOutIcon('Full Name', fullName, 'Name'),
            Row(
              children: [
                Expanded(
                    child: TextFormFieldWithOutIcon('Male', gender, 'Gender')),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: TextFormFieldWithOutIcon(
                        'Jan 1 2022', dateOfBirth, 'Date of Birth')),
              ],
            ),
            TextFormFieldWithOutIcon('Ghioon@gmail.com', email, 'Email'),
            TextFormFieldWithOutIcon('+251912345678', phone, 'Phone'),
            TextFormFieldWithOutIcon(
                'Jemo Michael, AA, Ethiopia', address, 'Address'),
          ],
        ),
      ),
    );
  }
}
