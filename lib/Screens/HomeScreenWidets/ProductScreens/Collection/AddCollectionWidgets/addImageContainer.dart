import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ghioon_seller/Providers/CollectionProvider.dart';
import 'package:ghioon_seller/Providers/language_provider.dart';
import 'package:ghioon_seller/Shared/language.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../Providers/RangeProvider.dart';
import '../../../../../Models/addProductmodels.dart';
import '../../../../../Shared/customColors.dart';
import '../../../../components/alert.dart';

class AddCollectionImageContainer extends StatefulWidget {
  const AddCollectionImageContainer({super.key});

  @override
  State<AddCollectionImageContainer> createState() =>
      _AddCollectionImageContainerState();
}

class _AddCollectionImageContainerState
    extends State<AddCollectionImageContainer> {
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    var languageprov = Provider.of<LanguageProvider>(context);
    final appState = Provider.of<CollectionData>(context);
    var _images = context.watch<CollectionData>().collectionImage;
    Future pickImage(ImageSource source) async {
      final image = await _picker.pickImage(
        source: source,
      );

      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        print("#########");
        _images[0].photo = imageTemporary;
        print(_images);
        print("#########");
      });
    }

    removeImage() {
      setState(() {
        _images[0].photo = null;
      });
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: SizedBox(
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
                            Language()
                                .choose_option[languageprov.LanguageIndex],
                            style: TextStyle(
                                color: CustomColors().blue,
                                fontWeight: FontWeight.bold),
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                alertLists(
                                    icon: Icons.camera,
                                    title: Language()
                                        .camera[languageprov.LanguageIndex],
                                    onTap: () {
                                      Navigator.pop(context);
                                      pickImage(ImageSource.camera);
                                    }),
                                alertLists(
                                    icon: Icons.photo_library,
                                    title: Language()
                                        .gallary[languageprov.LanguageIndex],
                                    onTap: () {
                                      Navigator.pop(context);
                                      pickImage(ImageSource.gallery);
                                    }),
                                alertLists(
                                    icon: Icons.delete,
                                    title: Language()
                                        .remove[languageprov.LanguageIndex],
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0), //or 15.0
                  child: Container(
                    child: _images[0].photo != null
                        ? Image.file(
                            _images[0].photo!,
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
              )),
        ),
      ]),
    );
  }
}
