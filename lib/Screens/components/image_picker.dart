import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/Product_components/RangeProvider.dart';

import 'package:ghioon_seller/Shared/customColors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddImage extends StatefulWidget {
  String? imagefromList;
  AddImage({super.key, this.imagefromList});

  @override
  State<AddImage> createState() => AddImageState();
}

class AddImageState extends State<AddImage> {
  File? image;
  final ImagePicker _picker = ImagePicker();

  Future pickImage(ImageSource source) async {
    final image = await _picker.pickImage(
      source: source,
    );

    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });
  }

  removeImage() {
    setState(() {
      this.image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<RangeData>(context);
    return SizedBox(
        height: 115,
        width: 115,
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0), //or 15.0
              child: Container(
                height: 90.0,
                width: 90.0,
                child: image != null
                    ? Image.file(
                        image!,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        size: 80,
                        Icons.add_a_photo,
                        color: CustomColors().blue,
                      ),
                // Image(image: AssetImage('assets/images/ima.png')),
              ),
            ),
          ),
        ));
  }

  Widget alertLists({
    Key? key,
    String? title,
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return InkWell(
      splashColor: CustomColors().blue,
      onTap: onTap,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 20, 10),
            child: Icon(icon, color: CustomColors().blue),
          ),
          Text(
            title!,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          )
        ],
      ),
    );
  }
}
