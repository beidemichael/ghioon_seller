import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Providers/language_provider.dart';
import 'package:ghioon_seller/Screens/components/alertDialog.dart';
import 'package:ghioon_seller/Screens/components/emptyScreen.dart';
import 'package:ghioon_seller/Service/Category/AddCategoryDatabase.dart';
import 'package:ghioon_seller/Shared/customColors.dart';
import 'package:ghioon_seller/Shared/dimensions.dart';
import 'package:ghioon_seller/Shared/language.dart';
import 'package:provider/provider.dart';

import '../../Product/ProductDetail/productCard.dart';
import '../../Product/ProductDetail/productDetail.dart';

class CollectionDetail extends StatefulWidget {
  String collection_name;
  String collection_description;

  CollectionDetail(
      {super.key,
      required this.collection_name,
       this.collection_description = ''});

  @override
  State<CollectionDetail> createState() => _CollectionDetailState();
}

class _CollectionDetailState extends State<CollectionDetail> {
  Deletedialog(var businessType, var userUid) {
    
    PopupDialog alert =
        PopupDialog("Are You Sure you want to Delete the Bussiness Category?", ()async {
     // print(appState.isLoading);


 Navigator.of(context).pop();
     await AddCategoryDatabase().removeCategory(businessType, userUid) .then((value) => print("Category Deleted"));
                              
                              
     
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

    CantDeletedialog() {
    PopupDialogDone alert =
        PopupDialogDone("Can't Delete! You must have atleast one Bussiness Category.", ()async {
      Navigator.of(context).pop();

    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    var languageprov = Provider.of<LanguageProvider>(context);
    final categoryitems = Provider.of<List<Product>>(context);
    final userInfo = Provider.of<List<UserInformation>>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
            actions: [
              IconButton(icon:Icon(Icons.delete), onPressed:userInfo[0].businessCategory.length !=1? (){
                 final userUid = FirebaseAuth.instance.currentUser!.uid;
                Deletedialog(widget.collection_name,userUid);
              }:(){

                 CantDeletedialog();
               // Deletedialog(widget.collection_name,userUid);
              },),
              SizedBox(
                width: 20,
              )
            ],
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(widget.collection_name,
                    style: TextStyle(
                        fontSize: Dimensions.font23,
                        color: Colors.white,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            // excludeHeaderSemantics: true,
            backgroundColor: CustomColors().blue,
            // automaticallyImplyLeading: false,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            iconTheme: IconThemeData(color: Colors.white)),
      ),
      body: Padding(
        padding:  EdgeInsets.fromLTRB(Dimensions.width10, 0, Dimensions.width10, 0),
        child: Column(children: [
          // Text(
          //   widget.collection_description,
          //   style: TextStyle(
          //       fontSize: 22, fontFamily: 'INTER', fontWeight: FontWeight.w400),
          //   textAlign: TextAlign.center,
          // ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Text(
              //   "Products in Collection",
              //   style: TextStyle(
              //       fontSize: 22,
              //       fontFamily: 'INTER',
              //       fontWeight: FontWeight.bold),
              //   textAlign: TextAlign.left,
              // ),
            ],
          ),
          Expanded(
            child: Container(
              // height: MediaQuery.of(context).size.height,
              child: categoryitems.length == 0
                  ? EmptyScreen(context,
                      Language().No_products[languageprov.LanguageIndex])
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: categoryitems.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                              Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetail(
                                      product: categoryitems[index],
                                    )),
                          );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ProductList(
                              title: categoryitems[index].name,
                              stock: categoryitems[index].quantity.toString(),
                              image: categoryitems[index].image,
                              edit: true,
                              item: categoryitems[index],
                              index: index,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ]),
      ),
    );
  }
}
