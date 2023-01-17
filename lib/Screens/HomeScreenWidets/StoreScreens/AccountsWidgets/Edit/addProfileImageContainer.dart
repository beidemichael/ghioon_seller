import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Shared/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../../Models/models.dart';
import '../../../../../Service/Profile/ProfileDatabase.dart';
import '../../../../../Service/uploadPhoto.dart';
import '../../../../../Shared/customColors.dart';
import '../../../../components/alert.dart';

class AddProfileImageContainer extends StatefulWidget {
  @override
  State<AddProfileImageContainer> createState() =>
      _AddProfileImageContainerState();
}

class _AddProfileImageContainerState extends State<AddProfileImageContainer> {
  final ImagePicker _picker = ImagePicker();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final userInfo = Provider.of<List<UserInformation>>(context);
    // final products = Provider.of<List<Product>>(context);
    Future pickImage(
        ImageSource source, int index, UserInformation user) async {
      final image = await _picker.pickImage(
        source: source,
      );

      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        loading = true;
      });
      var uploadedPhoto = await uploadImage(
          imageTemporary, FirebaseAuth.instance.currentUser!.uid, 'Profile');
      ProfileDatabase().addImage(uploadedPhoto, user.documentId);
      setState(() {
        loading = false;
      });
    }

    removeImage(int index, UserInformation user) {
      setState(() {
        loading = true;
      });
      ProfileDatabase().deleteImage(user.documentId, index);
      setState(() {
        loading = false;
      });
    }

    return userInfo.isEmpty
        ? Loading()
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              userInfo[0].profileImages.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          shrinkWrap: true,
                          itemCount: userInfo[0].profileImages.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Center(
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8.0)),
                                            child: Container(
                                              //image
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                              ),
                                              child: userInfo[0].profileImages[
                                                          index] !=
                                                      ''
                                                  ? ClipRRect(
                                                      child: CachedNetworkImage(
                                                        fit: BoxFit.cover,
                                                        imageUrl: userInfo[0]
                                                                .profileImages[
                                                            index],
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                    downloadProgress) =>
                                                                Center(
                                                          child: Container(
                                                            height: 20,
                                                            width: 20,
                                                            child: CircularProgressIndicator(
                                                                valueColor:
                                                                    AlwaysStoppedAnimation<
                                                                        Color>(Colors
                                                                            .grey[
                                                                        300]!),
                                                                value: downloadProgress
                                                                    .progress),
                                                          ),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                      ),
                                                    )
                                                  : Center(
                                                      child: Icon(
                                                        FontAwesomeIcons
                                                            .solidImage,
                                                        size: 40,
                                                        color: Colors.grey[400],
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Visibility(
                                              visible: userInfo[0]
                                                      .profileImages
                                                      .length !=
                                                  1,
                                              child: SizedBox(
                                                height: 30,
                                                width: 30,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    removeImage(
                                                        index, userInfo[0]);
                                                  },
                                                  child: Container(
                                                    height: 25,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color:
                                                          CustomColors().white,
                                                      boxShadow: const <
                                                          BoxShadow>[
                                                        BoxShadow(
                                                            color:
                                                                Color.fromARGB(
                                                                    137,
                                                                    95,
                                                                    93,
                                                                    93),
                                                            blurRadius: 2.0,
                                                            offset:
                                                                Offset(0.0, 2))
                                                      ],
                                                    ),
                                                    child: Icon(
                                                      FontAwesomeIcons.xmark,
                                                      color:
                                                          CustomColors().blue,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible:
                                          userInfo[0].profileImages.length -
                                                  1 ==
                                              index,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 0, 0),
                                        child: GestureDetector(
                                          onTap: () {
                                            print("add");
                                            // appState.addToImageList(ImageList());
                                            print('Change image');
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      'Choose option',
                                                      style: TextStyle(
                                                          color: CustomColors()
                                                              .blue,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: ListBody(
                                                        children: [
                                                          alertLists(
                                                              icon:
                                                                  Icons.camera,
                                                              title: 'Camera',
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                                pickImage(
                                                                    ImageSource
                                                                        .camera,
                                                                    index,
                                                                    userInfo[
                                                                        0]);
                                                              }),
                                                          alertLists(
                                                              icon: Icons
                                                                  .photo_library,
                                                              title: 'Gallary',
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                                pickImage(
                                                                    ImageSource
                                                                        .gallery,
                                                                    index,
                                                                    userInfo[
                                                                        0]);
                                                              }),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Container(
                                            height: 90,
                                            width: 90,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: CustomColors().white,
                                              border: Border.all(
                                                  width: 1,
                                                  color: const Color.fromARGB(
                                                      255, 199, 199, 199)),
                                            ),
                                            child: loading == true
                                                ? SpinKitCircle(
                                                    color: Colors.grey,
                                                    size: 40.0,
                                                  )
                                                : const Icon(
                                                    size: 50,
                                                    FontAwesomeIcons.add,
                                                    color: Color.fromARGB(
                                                        255, 204, 204, 204),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () {
                          print("add");
                          // appState.addToImageList(ImageList());
                          print('Change image');
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Choose option',
                                    style: TextStyle(
                                        color: CustomColors().blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        alertLists(
                                            icon: Icons.camera,
                                            title: 'Camera',
                                            onTap: () {
                                              Navigator.pop(context);
                                              pickImage(ImageSource.camera, 0,
                                                  userInfo[0]);
                                            }),
                                        alertLists(
                                            icon: Icons.photo_library,
                                            title: 'Gallary',
                                            onTap: () {
                                              Navigator.pop(context);
                                              pickImage(ImageSource.gallery, 0,
                                                  userInfo[0]);
                                            }),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: CustomColors().white,
                            border: Border.all(
                                width: 1,
                                color:
                                    const Color.fromARGB(255, 199, 199, 199)),
                          ),
                          child: loading == true
                              ? SpinKitCircle(
                                  color: Colors.grey,
                                  size: 40.0,
                                )
                              : const Icon(
                                  size: 50,
                                  FontAwesomeIcons.add,
                                  color: Color.fromARGB(255, 204, 204, 204),
                                ),
                        ),
                      ),
                    ),
            ],
          );
  }
}
