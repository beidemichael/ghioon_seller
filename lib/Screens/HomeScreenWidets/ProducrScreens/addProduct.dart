import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Models/addProductmodels.dart';
import 'package:ghioon_seller/Providers/RangeProvider.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/AddProductsWidgets/addImageContainer.dart';
import 'package:ghioon_seller/Screens/components/BlueButton.dart';
import 'package:ghioon_seller/Screens/components/alert.dart';
import 'package:ghioon_seller/Screens/components/alertDialog.dart';
import 'package:ghioon_seller/Screens/components/image_picker.dart';
import 'package:ghioon_seller/Screens/components/loadingWidget.dart';
import 'package:ghioon_seller/Service/uploadPhoto.dart';
import 'package:ghioon_seller/Shared/customColors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../components/textFormField.dart';
import 'AddProductsWidgets/addProductDetailContainer.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? image;

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final appState = Provider.of<RangeData>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text('Add Products',
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
            iconTheme: IconThemeData(color: CustomColors().white)),
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
                        child: const Center(child: AddImageContainer())),
                    const SizedBox(height: 15),
                    const addProductDetail(),
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
                    height: height, message: "Adding Product . . ."),
              ))
        ],
      ),
    );
  }
}
