import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../Providers/RangeProvider.dart';
import '../../../../Models/addProductmodels.dart';
import '../../../../Shared/customColors.dart';
import '../../../components/alert.dart';

class AddImageContainer extends StatefulWidget {
  const AddImageContainer({super.key});

  @override
  State<AddImageContainer> createState() => _AddImageContainerState();
}

class _AddImageContainerState extends State<AddImageContainer> {
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<RangeData>(context);
    var _images = context.watch<RangeData>().Images;
    Future pickImage(ImageSource source, int index) async {
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

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
      child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                  pickImage(ImageSource.camera,
                                                      index);
                                                }),
                                            alertLists(
                                                icon: Icons.photo_library,
                                                title: 'Gallary',
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  pickImage(ImageSource.gallery,
                                                      index);
                                                }),
                                            alertLists(
                                                icon: Icons.delete,
                                                title: 'Remove',
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
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(20.0), //or 15.0
                                  child: Container(
                                    child: _images[index].photo != null
                                        ? Image.file(
                                            _images[index].photo!,
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
                                Positioned(
                                    top: -5,
                                    right: 0,
                                    child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: FloatingActionButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              side: BorderSide(
                                                  color: Colors.white)),
                                          backgroundColor: Color(0xFFF5F6F9),
                                          onPressed: () {
                                            appState
                                                .removeImage(_images[index]);
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: CustomColors().blue,
                                          ),
                                        )))
                              ],
                            ),
                          )),
                    );
                  }),
            ),
            GestureDetector(
              onTap: () {
                print("add");
                appState.addToImageList(ImageList());
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(20)),
                ),
                child: Icon(
                  size: 80,
                  Icons.add,
                  color: CustomColors().blue,
                ),
              ),
            ),
          ]),
    );
  }
}
