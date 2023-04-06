// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ghioon_seller/Providers/CollectionProvider.dart';
import 'package:ghioon_seller/Providers/language_provider.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProductScreens/Collection/AddCollectionWidgets/addCollectionDetailsLogic/addCollectionDetailsLogic.dart';
import 'package:ghioon_seller/Screens/components/BlueButton.dart';
import 'package:ghioon_seller/Screens/components/alertDialog.dart';
import 'package:ghioon_seller/Screens/components/textFormField.dart';
import 'package:ghioon_seller/Shared/language.dart';
import 'package:provider/provider.dart';

class addCollectionDetail extends StatefulWidget {
  const addCollectionDetail({super.key});

  @override
  State<addCollectionDetail> createState() => _addCollectionDetailState();
}

class _addCollectionDetailState extends State<addCollectionDetail> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<CollectionData>(context);
    var languageprov = Provider.of<LanguageProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            TextFormFieldProduct(
                Language().Enter_product_name[languageprov.LanguageIndex],
                appState.collectionName,
                "Product Name"),
            TextFormFieldProDescription(
                Language().description[languageprov.LanguageIndex],
                appState.collectionDescription,
                "Description"),
            Visibility(
              visible: !appState.productDescriptionFilled,
              child: Center(
                child: Text(
                  Language().please_fill_all_field[languageprov.LanguageIndex],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.red),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () async {
                  //Check if Product Name and Description is filled
                  AddCollectionLogic().checkProductNameandDescription(context);
                  //Check if Range and Fixed fields are filled
                  //If All fields are filled==>

                  if (appState.productDescriptionFilled) {
                    appState.isLoading = true;
                    // AddProductDetailLogic().showDialog(context);

                    PopupDialog alert = PopupDialog(
                        Language().Are_you_sure_collection[
                            languageprov.LanguageIndex], () {
                      //  print(appState.isLoading);
                      AddCollectionLogic()
                          .addCollection(context)
                          .then((value) => appState.isLoading = false);
                    }, () {
                      Navigator.pop(context);
                    });

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  }
                },
                child: BlueButton(
                    text:
                        Language().add_collection[languageprov.LanguageIndex]))
          ]),
    );
  }
}
