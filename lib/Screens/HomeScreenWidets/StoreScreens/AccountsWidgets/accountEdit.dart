import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/StoreScreens/AccountsWidgets/profileImage.dart';
import 'package:ghioon_seller/Screens/components/textFormField.dart';
import 'package:ghioon_seller/Service/registerDatabase.dart';

import '../../../../Shared/customColors.dart';
import 'package:provider/provider.dart';
import '../../../../Models/models.dart';

class AccountEdit extends StatefulWidget {
  var appState;
  UserInformation user;
  AccountEdit({super.key, required this.appState, required this.user});

  @override
  State<AccountEdit> createState() => _AccountEditState();
}

class _AccountEditState extends State<AccountEdit> {
  bool loading = false;

  @override
  void dispose() {
    super.dispose();
    // fullName.dispose();
    // gender.dispose();
    // dateOfBirth.dispose();
    // email.dispose();
    // businessNo.dispose();
    // address.dispose();
  }

  void initState() {
    // TODO: implement initState
    super.initState();

    widget.appState.fullName.text = widget.user.userName;
    widget.appState.businessName.text = widget.user.businessName;
    widget.appState.email.text = widget.user.email;
    widget.appState.businessNo.text = widget.user.businessNo;
    widget.appState.address.text = widget.user.address;
    widget.appState.uploadedImage = widget.user.image;
    print(widget.appState.uploadedImage);
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserInformation>>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(280.0),
        child: Column(
          children: [
            AppBar(
                actions: [
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        loading = true;
                      });
                      print("loading");
                      await RegisterDatabaseService().editUserProfile(
                          widget.appState.fullName.text,
                          widget.appState.businessName.text,
                          widget.appState.email.text,
                          widget.appState.businessNo.text,
                          widget.appState.address.text,
                          widget.user.userUid,
                          widget.appState.image);

                      setState(() {
                        loading = false;
                      });

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
                          child: loading
                              ? SpinKitCircle(
                                  size: 40,
                                  color: CustomColors().blue,
                                )
                              : Icon(
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
                        AddProfileImage(
                          appState: widget.appState,
                          user: widget.user,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(widget.appState.fullName.text,
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
            TextFormFieldWithOutIcon('Store Name', widget.appState.businessName,
                'Store Name', TextInputType.text),
            TextFormFieldWithOutIcon('Full Name', widget.appState.fullName,
                'Owner Name', TextInputType.text),
            TextFormFieldWithOutIcon(
                'email', widget.appState.email, 'Email', TextInputType.text),
            TextFormFieldWithOutIcon(
                '+Business Number',
                widget.appState.businessNo,
                'Business Number',
                TextInputType.number),
            TextFormFieldWithOutIcon('Jemo Michael, AA, Ethiopia',
                widget.appState.address, 'Address', TextInputType.text),
          ],
        ),
      ),
    );
  }
}
