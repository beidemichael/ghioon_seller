// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProductScreens/Product/AddProductsWidgets/addProductDetailWidgets/1,fixedButton.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProductScreens/Product/AddProductsWidgets/addProductDetailWidgets/1,rangeButton.dart';
import 'package:ghioon_seller/Service/Category/AddCategoryDatabase.dart';
import 'package:ghioon_seller/Shared/language.dart';
import 'package:provider/provider.dart';
import '../../../../../Providers/RangeProvider.dart';
import '../../../../../Models/addProductmodels.dart';
import '../../../../../Providers/language_provider.dart';
import '../../../../../Service/Product/AddProductDatabase.dart';
import '../../../../../Service/uploadPhoto.dart';
import '../../../../../Shared/customColors.dart';
import '../../../../components/BlueButton.dart';
import '../../../../components/alertDialog.dart';
import '../../../../components/textFormField.dart';
import 'addProductDetailLogic/addProductDetailLogic.dart';
import 'addProductDetailWidgets/2,fixedInputField.dart';
import 'addProductDetailWidgets/2,rangeInputField.dart';
import 'addProductDetailWidgets/3,inventoryQty.dart';

class addProductDetail extends StatefulWidget {
  const addProductDetail({super.key});

  @override
  State<addProductDetail> createState() => _addProductDetailState();
}

class _addProductDetailState extends State<addProductDetail> {
 
   String selectedCatagoryValue = '';

  @override
  Widget build(BuildContext context) {
    var languageprov = Provider.of<LanguageProvider>(context);
    final appState = Provider.of<RangeData>(context);
    final userInfo = Provider.of<List<UserInformation>>(context);
    final Allcategories = Provider.of<List<Categories>>(context);

// collections
    // List<String> catagories = [];
    // if (userInfo.isNotEmpty) {
    //   for (int i = 0; i < userInfo[0].collections.length; i++) {
    //     catagories.add(userInfo[0].collections[i]);
    //     // print(userInfo[0].collections[i]);
    //     // print(catagories);
    //     // print("33333333333333333333333333333333333333333");
    //   }
    // }

//make bussiness catagory map to list
    List<String> user_catagories = [];
    List<String> Allcatagories_name = [];
    List<String> Allcatagories_type = [];
    
    if (userInfo.isNotEmpty) {
      for (int i = 0; i < userInfo[0].businessCategory.length; i++) {
        user_catagories.add(userInfo[0].businessCategory[i]);
       
       
       
      }
    }


    if (Allcategories.isNotEmpty) {
      for (int i = 0; i < Allcategories.length; i++) {
        Allcatagories_name.add(Allcategories[i].name);
        Allcatagories_type.add(Allcategories[i].type);
        
      }
    }

    

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          TextFormFieldProduct(
              Language().Enter_product_name[languageprov.LanguageIndex],
              appState.productName,
              Language().product_name[languageprov.LanguageIndex]),
          TextFormFieldProDescription(
              Language().description[languageprov.LanguageIndex],
              appState.description,
              Language().description[languageprov.LanguageIndex]),
          // DropdownButtonFormField(
          //     decoration: InputDecoration(
          //       hintText: 'Select Product Type',
          //       enabledBorder: OutlineInputBorder(
          //         borderSide:
          //             BorderSide(color: CustomColors().lightgrey, width: 2),
          //         borderRadius: BorderRadius.circular(20),
          //       ),
          //       border: OutlineInputBorder(
          //         borderSide:
          //             BorderSide(color: CustomColors().white, width: 2),
          //         borderRadius: BorderRadius.circular(20),
          //       ),
          //       // filled: false,
          //       // fillColor: Colors.blueAccent,
          //     ),
          //     validator: (value) =>
          //         value == null ? "Select a country" : null,
          //     dropdownColor: Colors.white,
          //     value: appState.selectedValue,
          //     onChanged: (String? newValue) {
          //       setState(() {
          //         appState.selectedValue = newValue!;
          //       });
          //     },
          //     items: appState.dropdownItems),
          SizedBox(
            height: 10,
          ),

          
  //         DropdownButtonFormField(
  //           decoration: InputDecoration(
  //             hintText: 'Select Product Catagory',
  //             enabledBorder: OutlineInputBorder(
  //               borderSide:
  //                   BorderSide(color: CustomColors().lightgrey, width: 2),
  //               borderRadius: BorderRadius.circular(20),
  //             ),
  //             border: OutlineInputBorder(
  //               borderSide:
  //                   BorderSide(color: CustomColors().grey, width: 2),
  //               borderRadius: BorderRadius.circular(20),
  //             ),
  //             // filled: false,
  //             // fillColor: Colors.blueAccent,
  //           ),
  //           validator: (value) => value == null ? "Select Product Catagory" : null,
  //           dropdownColor: Colors.white,
  //           value: appState.selectedCatagoryValue,
  //            onChanged: (value) {
  //   setState(() {
  //     selectedCatagoryValue = value!;
  //   });
  //   // Do something with the selected value
  // },
  //          items: catagories.map((String value) {
  //   return DropdownMenuItem<String>(
  //     value: value,
  //     child: Text(value),
  //   );
  // }).toList(),

            
          // ),

          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              hintText:  Language().Select_Product_Catagory[languageprov.LanguageIndex],
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: CustomColors().lightgrey, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: CustomColors().grey, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              // filled: false,
              // fillColor: Colors.blueAccent,
            ),
            value: appState.selectedCatagoryValue =='' ?appState. selectedCatagoryValue : null,
            validator: (value) => value == null ? Language().Select_Product_Catagory[languageprov.LanguageIndex] : null,
            items: Allcatagories_name.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
               
              appState. selectedCatagoryValue = Allcatagories_type[ Allcatagories_name.indexOf(value!)];
              print(appState.selectedCatagoryValue);
              });
              // Do something with the selected value
            },
            
          ),

          SizedBox(
            height: 10,
          ),
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
          // const Text(
          //   "Price",
          //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          // ),
          // Row(
          //   children: [
          //     Flexible(
          //         child: GestureDetector(
          //             onTap: () {
          //               !appState.fixed
          //                   ? Provider.of<RangeData>(context, listen: false)
          //                       .switchFixed(appState.fixed)
          //                   : null;
          //             },
          //             child: FixedButton(fixed: appState.fixed))),
          //     const SizedBox(
          //       width: 15,
          //     ),
          //     Flexible(
          //         child: GestureDetector(
          //             onTap: () {
          //               appState.fixed
          //                   ? Provider.of<RangeData>(context, listen: false)
          //                       .switchFixed(appState.fixed)
          //                   : null;
          //             },
          //             child: RangeButton(fixed: appState.fixed))),
          //   ],
          // ),
          const SizedBox(
            height: 10,
          ),
          // appState.fixed
          //     ? const FixedInputField()
          //     : const RangeInputField(),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
              onTap: () async {
                print("loading");

                //Check if image is filled
                AddProductDetailLogic().checkImage(context);
                //Check if Product Name and Description is filled
                AddProductDetailLogic().checkProductNameandDescription(context);
                //Check if Range and Fixed fields are filled
                AddProductDetailLogic().checkFixedAndRange(context);
                //If All fields are filled==>
                if (appState.fixed) {
                  if (appState.imageFilled &&
                      appState.productDescriptionFilled &&
                      appState.fixedFilled &&
                      appState.videoLessThanSix &&
                      appState.videoSquare) {
                    // appState.isLoading = true;
                    // dialog();

                    //=== Dialog box
                    final appState = Provider.of<RangeData>(context, listen: false);
    
                    PopupDialog alert =
                        PopupDialog("Are You Sure you want to add the product?", ()async {
                      print(appState.isLoading);
                      appState.isLoading = true;
                      if(!user_catagories.contains(appState. selectedCatagoryValue) ){
                        List<String> newcataegory = [appState. selectedCatagoryValue];
                          await AddCategoryDatabase().addCategory(newcataegory, userInfo[0].userUid);
                      }
                      AddProductDetailLogic()
                          .addProduct(context)
                          .then((value) => appState.isLoading = false);
                    }, () {
                      Navigator.pop(context);
                      appState.isLoading = false;
                    });
                appState.isLoading = true;
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );

                    


                    
                  }
                } else {
                  if (appState.imageFilled &&
                      appState.productDescriptionFilled &&
                      appState.rangefilled &&
                      appState.videoLessThanSix &&
                      appState.videoSquare) {
                  //  appState.isLoading = true;
                    // AddProductDetailLogic().showDialog(context);

                   // dialog();
                      final appState = Provider.of<RangeData>(context, listen: false);
    
                    PopupDialog alert =
                        PopupDialog(Language().alert_edit_product[languageprov.LanguageIndex], () {
                      print(appState.isLoading);
                      appState.isLoading = true;
                      AddProductDetailLogic()
                          .addProduct(context)
                          .then((value) => appState.isLoading = false);
                    }, () {
                      Navigator.pop(context);
                      appState.isLoading = false;
                    });
                appState.isLoading = true;
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  }
                }

                print("not loading");
              },
              child: BlueButton(
                  text: Language().continuee[languageprov.LanguageIndex]))
        ],
      ),
    );
  }
}
