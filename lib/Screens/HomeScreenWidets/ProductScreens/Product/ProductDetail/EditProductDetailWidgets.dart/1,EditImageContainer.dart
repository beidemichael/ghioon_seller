import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Service/Compression/image_compression.dart';
import 'package:ghioon_seller/Shared/language.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../../Providers/EditRangeProvider.dart';
import '../../../../../../Providers/language_provider.dart';
import '../../../../../../Service/Product/AddProductDatabase.dart';
import '../../../../../../Service/uploadPhoto.dart';
import '../../../../../../Shared/customColors.dart';
import '../../../../../components/alert.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class EditImageContainer extends StatefulWidget {
  int index;
  EditImageContainer({super.key, required this.index});

  @override
  State<EditImageContainer> createState() => _EditImageContainerState();
}

class _EditImageContainerState extends State<EditImageContainer> {
  final ImagePicker _picker = ImagePicker();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var languageprov = Provider.of<LanguageProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final appState = Provider.of<EditRangeData>(context);
    final products = Provider.of<List<Product>>(context);
    // var _images = context.watch<RangeData>().Images;
    Future pickImage(ImageSource source, int index) async {
      // final file = await ImagePicker().pickVideo(source: ImageSource.gallery);

      final image = await _picker.pickImage(
        source: source,
      );

      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        loading = true;
      });
      var uploadedPhoto = await uploadImage(
           await changeImage(imageTemporary,context), FirebaseAuth.instance.currentUser!.uid, 'Products');
      AddProductDatabase()
          .addImage(uploadedPhoto, products[widget.index].documentId);
      setState(() {
        loading = false;
      });
    }

    removeImage(int index) {
      setState(() {
        loading = true;
      });
      AddProductDatabase()
          .deleteImage(products[widget.index].documentId, index);
      setState(() {
        loading = false;
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
              itemCount: products[widget.index].image.length,
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                                child: Container(
                                  //image
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                  ),
                                  child: products[widget.index].image[index] !=
                                          ''
                                      ? ClipRRect(
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: products[widget.index]
                                                .image[index],
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Center(
                                              child: Container(
                                                height: 20,
                                                width: 20,
                                                child: CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Colors.grey[300]!),
                                                    value: downloadProgress
                                                        .progress),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        )
                                      : Center(
                                          child: Icon(
                                            Icons.image,
                                            size: 10,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Visibility(
                                  visible:
                                      products[widget.index].image.length != 1,
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: GestureDetector(
                                      onTap: () {
                                        removeImage(index);
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
                          visible:
                              products[widget.index].image.length - 1 == index,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: GestureDetector(
                              onTap: () {
                                //      print("add");
                                // appState.addToImageList(ImageList());
                                //    print('Change image');
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          Language().choose_option[
                                              languageprov.LanguageIndex],
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
                                                      languageprov
                                                          .LanguageIndex],
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    pickImage(
                                                        ImageSource.camera,
                                                        index);
                                                  }),
                                              alertLists(
                                                  icon: Icons.photo_library,
                                                  title: Language().gallary[
                                                      languageprov
                                                          .LanguageIndex],
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    pickImage(
                                                        ImageSource.gallery,
                                                        index);
                                                  }),
                                              alertLists(
                                                  icon: Icons.delete,
                                                  title: Language().remove[
                                                      languageprov
                                                          .LanguageIndex],
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
                                child: loading == true
                                    ? SpinKitCircle(
                                        color: Colors.grey,
                                        size: 40.0,
                                      )
                                    : const Icon(
                                        size: 50,
                                        FontAwesomeIcons.add,
                                        color:
                                            Color.fromARGB(255, 204, 204, 204),
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
