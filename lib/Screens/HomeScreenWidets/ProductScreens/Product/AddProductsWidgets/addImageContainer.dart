import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Shared/language.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../Providers/RangeProvider.dart';
import '../../../../../Models/addProductmodels.dart';
import '../../../../../Providers/language_provider.dart';
import '../../../../../Shared/customColors.dart';
import '../../../../components/alert.dart';

class AddImageContainer extends StatefulWidget {
  const AddImageContainer({super.key});

  @override
  State<AddImageContainer> createState() => _AddImageContainerState();
}

class _AddImageContainerState extends State<AddImageContainer> {
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    var languageprov = Provider.of<LanguageProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final appState = Provider.of<RangeData>(context);
    var _images = context.watch<RangeData>().Images;
    Future pickImage(ImageSource source, int index) async {
      // final file = await ImagePicker().pickVideo(source: ImageSource.gallery);
      final image = await _picker.pickImage(
        source: source,
      );

      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        _images[index].photo = imageTemporary;
      });
    }

    removeImage(int index) {
      setState(() {
        _images[index].photo = null;
      });
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              shrinkWrap: true,
              itemCount: _images.length,
              itemBuilder: (context, index) {
                var currentImage = _images[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Center(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            //    print('Change image');
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
                                              title: Language().camera[
                                                  languageprov.LanguageIndex],
                                              onTap: () {
                                                Navigator.pop(context);
                                                pickImage(
                                                    ImageSource.camera, index);
                                              }),
                                          alertLists(
                                              icon: Icons.photo_library,
                                              title: Language().gallary[
                                                  languageprov.LanguageIndex],
                                              onTap: () {
                                                Navigator.pop(context);
                                                pickImage(
                                                    ImageSource.gallery, index);
                                              }),
                                          alertLists(
                                              icon: Icons.delete,
                                              title: Language().remove[
                                                  languageprov.LanguageIndex],
                                              onTap: () {
                                                Navigator.pop(context);
                                                removeImage(index);
                                              })
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: 1, color: CustomColors().blue),
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(20.0), //or 15.0
                                  child: Container(
                                    child: _images[index].photo != null
                                        ? Image.file(
                                            _images[index].photo!,
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color:
                                                  CustomColors().superLightBlue,
                                            ),
                                            child: Icon(
                                              size: 70,
                                              FontAwesomeIcons.image,
                                              color: CustomColors().blue,
                                            ),
                                          ),
                                    // Image(image: AssetImage('assets/images/ima.png')),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Visibility(
                                  visible: _images.length != 1,
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: GestureDetector(
                                      onTap: () {
                                        appState.removeImage(_images[index]);
                                      },
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: CustomColors().white,
                                          boxShadow: const <BoxShadow>[
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    137, 95, 93, 93),
                                                blurRadius: 2.0,
                                                offset: Offset(0.0, 2))
                                          ],
                                        ),
                                        child: Icon(
                                          FontAwesomeIcons.xmark,
                                          color: CustomColors().blue,
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
                          visible: _images.length - 1 == index,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: GestureDetector(
                              onTap: () {
                                //     print("add");
                                appState.addToImageList(ImageList());
                              },
                              child: Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: CustomColors().white,
                                  border: Border.all(
                                      width: 1,
                                      color: const Color.fromARGB(
                                          255, 199, 199, 199)),
                                ),
                                child: const Icon(
                                  size: 50,
                                  FontAwesomeIcons.add,
                                  color: Color.fromARGB(255, 204, 204, 204),
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
        ),
      ],
    );
  }
}
