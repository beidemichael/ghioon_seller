import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Providers/language_provider.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/StoreScreens/AccountsWidgets/profileImage.dart';
import 'package:ghioon_seller/Screens/components/textFormField.dart';
import 'package:ghioon_seller/Service/registerDatabase.dart';
import 'package:ghioon_seller/Shared/language.dart';
import 'package:ghioon_seller/Shared/loading.dart';

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
    var languageprov = Provider.of<LanguageProvider>(context);
    final userInfo = Provider.of<List<UserInformation>>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
          toolbarHeight: 100,
          centerTitle: true,
          title: Text(widget.appState.businessName.text,
              style: TextStyle(
                  fontSize: 25.0,
                  color: CustomColors().white,
                  fontWeight: FontWeight.w500)),
          // excludeHeaderSemantics: true,
          backgroundColor: CustomColors().blue,
          // automaticallyImplyLeading: false,
          elevation: 5,
          iconTheme: IconThemeData(color: CustomColors().white)),
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          AddProfileImage(
            appState: widget.appState,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                TextFormFieldWithOutIcon(
                    Language().business_name[languageprov.LanguageIndex],
                    widget.appState.businessName,
                    Language().business_name[languageprov.LanguageIndex],
                    TextInputType.text),
                TextFormFieldWithOutIcon(
                    Language().full_name[languageprov.LanguageIndex],
                    widget.appState.fullName,
                    Language().sellername[languageprov.LanguageIndex],
                    TextInputType.text),
                TextFormFieldWithOutIcon(
                    Language().email[languageprov.LanguageIndex],
                    widget.appState.email,
                    Language().email[languageprov.LanguageIndex],
                    TextInputType.text),
                TextFormFieldWithOutIcon(
                    Language().businessnum[languageprov.LanguageIndex],
                    widget.appState.businessNo,
                    Language().businessnum[languageprov.LanguageIndex],
                    TextInputType.number),
                TextFormFieldWithOutIcon(
                    'Jemo Michael, AA, Ethiopia',
                    widget.appState.address,
                    Language().address[languageprov.LanguageIndex],
                    TextInputType.text),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
