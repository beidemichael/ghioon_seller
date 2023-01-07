import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Providers/CollectionProvider.dart';
import 'package:ghioon_seller/Providers/EditProfileProvider.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/StoreScreens/AccountsWidgets/Edit/ProfileImageAndVideo.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/StoreScreens/AccountsWidgets/ViewImageAndVideo.dart';
import 'package:ghioon_seller/Screens/components/alert.dart';
import 'package:ghioon_seller/Shared/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../Providers/RangeProvider.dart';
import '../../../../../Models/addProductmodels.dart';
import '../../../../../Shared/customColors.dart';
import '../../../../Service/userDatabase.dart';

class AddProfileImage extends StatefulWidget {
  var appState;
  AddProfileImage({super.key, required this.appState});

  @override
  State<AddProfileImage> createState() => _AddProfileImageState();
}

class _AddProfileImageState extends State<AddProfileImage> {
  final ImagePicker _picker = ImagePicker();
  _ProfileImageAndProfileDialog(BuildContext context) {
    ProfileImageAndVideoBlurryDialog alert = ProfileImageAndVideoBlurryDialog();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StreamProvider<List<UserInformation>>.value(
          initialData: [],
          value: UserDatabaseService(
                  userUid: FirebaseAuth.instance.currentUser?.uid)
              .userInfo,
          child: alert,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserInformation>>(context);

    return userInfo.isEmpty
        ? Loading()
        : Container(
            color: Colors.white,
            height: (MediaQuery.of(context).size.width * 0.5) + 130,
            child: Stack(
              children: [
                Center(
                  child: Container(
                      color: CustomColors().white,
                      child: ViewImageAndVideo(
                        user: userInfo[0],
                      )),
                ),
                userInfo.isEmpty
                    ? Loading()
                    : Positioned(
                        bottom: 0,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            print('Change image');
                            _ProfileImageAndProfileDialog(
                              context,
                            );
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: CustomColors().white,
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  spreadRadius: 5,
                                  blurRadius: 8,
                                  offset: Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Icon(
                              FontAwesomeIcons.camera,
                              size: 20.0,
                              color: CustomColors().blue,
                            ),
                          ),
                        ),
                      )
              ],
            ),
          );
  }
}
