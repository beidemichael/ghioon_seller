import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Providers/language_provider.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/StoreScreens/AccountsWidgets/profileImage.dart';
import 'package:ghioon_seller/Screens/SignIn/Address.dart';
import 'package:ghioon_seller/Screens/components/textFormField.dart';
import 'package:ghioon_seller/Service/registerDatabase.dart';
import 'package:ghioon_seller/Shared/dimensions.dart';
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
    widget.appState.region = widget.user.region;
    widget.appState.zone = widget.user.zone;
    // print(widget.appState.uploadedImage);
  }

  int regionIndex = 0;
  @override
  Widget build(BuildContext context) {
    var languageprov = Provider.of<LanguageProvider>(context);
    final userInfo = Provider.of<List<UserInformation>>(context);
    print(widget.appState.region);
    print("region ====================");
    print(widget.appState.zone);
    print("region ====================");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () async {
                print(widget.appState.region);
                print(widget.appState.zone);
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
                    widget.appState.region,
                    widget.appState.zone,
                    widget.user.userUid,
                    widget.appState.image,
                    context);

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
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
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
                    Language().additional_address[languageprov.LanguageIndex],
                    widget.appState.address,
                    Language().address[languageprov.LanguageIndex],
                    TextInputType.text),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: CustomColors().lightgrey, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 5),
                    child: Row(
                      children: [
                        DropdownButton(
                          icon: const SizedBox(),
                          underline: SizedBox(),
                          dropdownColor: Colors.white,
                          value: widget.appState.region,
                          onChanged: (value) {
                            setState(() {
                              widget.appState.region = value!;
                              print(widget.appState.region);

                              widget.appState.zone = null;
                              widget.appState.region = value!;
                              widget.appState.regionIndex = AddressDetail()
                                  .regions
                                  .indexOf(widget.appState.region);
                              print(widget.appState.region);
                              print(regionIndex);
                            });
                            // Do something with the selected value
                          },
                          items: AddressDetail().regions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: Dimensions.font14),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            );
                          }).toList(),
                        ),
                        Expanded(
                          child: Icon(
                            FontAwesomeIcons.caretDown,
                            color: CustomColors().darkGrey,
                            size: Dimensions.height15,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    hintText:
                        Language().select_zone[languageprov.LanguageIndex],
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: CustomColors().lightgrey, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: CustomColors().grey, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // filled: false,
                    // fillColor: Colors.blueAccent,
                  ),
                  validator: (value) => value == null
                      ? Language().select_zone[languageprov.LanguageIndex]
                      : null,
                  dropdownColor: Colors.white,
                  value: widget.appState.zone,
                  onChanged: (value) {
                    setState(() {
                      widget.appState.zone = value!;
                      print(widget.appState.zone);
                    });
                    // Do something with the selected value
                  },
                  items: AddressDetail()
                      .Zone[AddressDetail()
                          .regions
                          .indexOf(widget.appState.region)]
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: Dimensions.font14),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
