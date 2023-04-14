import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Providers/language_provider.dart';
import 'package:ghioon_seller/Shared/language.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../Providers/EditRangeProvider.dart';
import '../../../../../Providers/RangeProvider.dart';
import '../../../../../Shared/customColors.dart';
import '../../../../components/loadingWidget.dart';
import 'EditProductDetailWidgets.dart/1,EditImageContainer.dart';
import 'EditProductDetailWidgets.dart/3,EditProductDetailContainer.dart';
import 'EditProductDetailWidgets.dart/2,EditVideoContainer.dart';

class EditProduct extends StatefulWidget {
  var product;
  int index;
  EditProduct({super.key, required this.product, required this.index});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  File? image;

  Widget build(BuildContext context) {
    var languageprov = Provider.of<LanguageProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final appState = Provider.of<EditRangeData>(context);
    Future pickVideo() async {
      final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
      if (video == null) return;
      final videoTemporary = File(video.path);
      setState(() {
        appState.video = videoTemporary;
      });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text(Language().edit_products[languageprov.LanguageIndex],
                  style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700)),
            ],
          ),
          backgroundColor: CustomColors().blue,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          iconTheme: IconThemeData(color: CustomColors().white),
        ),
      ),
      body: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    const SizedBox(height: 20),
                    Container(
                        height: height / 7,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(255, 207, 207, 207)),
                          color: CustomColors().white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                            child: EditImageContainer(
                          index: widget.index,
                        ))),
                    const SizedBox(height: 15),

                    // ======
                    //Edit video
                    //=======
                    // const SizedBox(height: 15),
                    // GestureDetector(
                    //   onTap: () {
                    //     print(
                    //         'VideoSquare: ' + appState.videoSquare.toString());
                    //     print('VideoSix: ' +
                    //         appState.videoLessThanSix.toString());
                    //   },
                    //   child: Container(
                    //     height: (width * .5) + 80,
                    //     decoration: BoxDecoration(
                    //       border: Border.all(
                    //           width: 1,
                    //           color: const Color.fromARGB(255, 207, 207, 207)),
                    //       color: CustomColors().white,
                    //       borderRadius: BorderRadius.circular(20.0),
                    //     ),
                    //     child: Center(
                    //       child: EditVideoContainer(
                    //         product: widget.product,
                    //         index: widget.index,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 15),
                    EditProductDetail(
                      product: widget.product,
                      appState: appState,
                    ),
                    const SizedBox(height: 15),
                  ])),
          Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Visibility(
                visible: appState.isLoading,
                child: LoadingWidget(
                    height: height,
                    message:
                        Language().adding_product[languageprov.LanguageIndex]),
              ))
        ],
      ),
    );
  }
}
