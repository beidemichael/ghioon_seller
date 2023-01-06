import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Providers/CollectionProvider.dart';
import 'package:ghioon_seller/Providers/EditProfileProvider.dart';
import 'package:ghioon_seller/Screens/components/alert.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../Providers/RangeProvider.dart';
import '../../../../../Models/addProductmodels.dart';
import '../../../../../Shared/customColors.dart';

class AddProfileImage extends StatefulWidget {
  var appState;
  UserInformation user;
  AddProfileImage({super.key, required this.appState, required this.user});

  @override
  State<AddProfileImage> createState() => _AddProfileImageState();
}

class _AddProfileImageState extends State<AddProfileImage> {
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    Future pickImage(ImageSource source) async {
      final image = await _picker.pickImage(
        source: source,
      );
      print(image!.path);

      if (image == null) {
        print('3333333333333333333333333');
        return;
      }
      ;

      final imageTemporary = image.path;
      setState(() {
        print(
            "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
        widget.appState.image = imageTemporary;
        print(widget.appState.image);
        print("#########");
      });
    }

    removeImage() {
      setState(() {
        widget.appState.image = '';
      });
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: SizedBox(
              height: 150,
              width: 150,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.0), //or 15.0
                    child: Container(
                      height: 150,
                      width: 150,
                      color: CustomColors().darkBlue,
                      child: widget.appState.image != ''
                          ? Image.file(
                              File(widget.appState.image),
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : widget.appState.uploadedImage != ''
                              ? CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: widget.appState.uploadedImage,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.grey[300]!),
                                          value: downloadProgress.progress),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                )
                              : Icon(
                                  FontAwesomeIcons.userLarge,
                                  size: 80.0,
                                  color: Colors.white,
                                ),
                    ),
                  ),
                  Positioned(
                      bottom: -10,
                      right: -10,
                      child: GestureDetector(
                        onTap: () {
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
                                              pickImage(ImageSource.camera);
                                            }),
                                        alertLists(
                                            icon: Icons.photo_library,
                                            title: 'Gallary',
                                            onTap: () {
                                              Navigator.pop(context);
                                              pickImage(ImageSource.gallery);
                                            }),
                                        alertLists(
                                            icon: Icons.delete,
                                            title: 'Remove',
                                            onTap: () {
                                              Navigator.pop(context);
                                              removeImage();
                                            })
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: CustomColors().white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(
                            FontAwesomeIcons.camera,
                            size: 20.0,
                            color: CustomColors().blue,
                          ),
                        ),
                      ))
                ],
              )),
        ),
      ]),
    );
  }
}
