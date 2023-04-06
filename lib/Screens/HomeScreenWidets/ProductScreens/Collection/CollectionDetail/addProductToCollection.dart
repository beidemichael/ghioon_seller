import 'package:flutter/material.dart';
import 'package:ghioon_seller/Providers/CollectionProvider.dart';
import 'package:ghioon_seller/Providers/language_provider.dart';
import 'package:ghioon_seller/Shared/customColors.dart';
import 'package:ghioon_seller/Shared/language.dart';
import 'package:provider/provider.dart';

import '../../../../../Models/models.dart';
import '../../Product/ProductDetail/productCard.dart';

class AddProToCollection extends StatefulWidget {
  const AddProToCollection({super.key});

  @override
  State<AddProToCollection> createState() => _AddProToCollectionState();
}

class _AddProToCollectionState extends State<AddProToCollection> {
  final search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var languageprov = Provider.of<LanguageProvider>(context);
    final products = Provider.of<List<Product>>(context);
    final collection = Provider.of<CollectionData>(context);
    collection.filtered = products;

    final collectionLogic = Provider.of<CollectionData>(context);

    fillterSearch(String query) {
      //   print(query);
      setState(() {
        final searched = products.where((product) {
          final productName = product.name.toLowerCase();
          final input = query.toLowerCase();

          return productName.contains(input);
        }).toList();

        collection.filtered = searched;

        for (var i = 0; i < collection.filtered.length; i++) {
          print(collection.filtered[i].name);
        }
      });
    }

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
              actions: [
                SizedBox(
                  width: 20,
                )
              ],
              centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(Language().add_product[languageprov.LanguageIndex],
                      style: TextStyle(
                          fontSize: 30.0,
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
          padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 0),
          child: Column(
            children: [
              // TextFormFieldSearch(
              //     "Search Products here", search, "Filter", fillterSearch(String value)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: search,
                      decoration: InputDecoration(
                        hintText: Language()
                            .search_product_here[languageprov.LanguageIndex],
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 214, 214, 214)),
                          gapPadding: 10,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: CustomColors().blue),
                          gapPadding: 10,
                        ),
                      ),
                      onChanged: ((value) => fillterSearch(value)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: collection.filtered.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProductList(
                            title: collection.filtered[index].name,
                            stock:
                                collection.filtered[index].quantity.toString(),
                            image: collection.filtered[index].image,
                            edit: false,
                            item: collection,
                            index: index,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }

// //Text widget for Product name in add product
//   Widget TextFormFieldSearch(String hintText, TextEditingController control,
//       String header, VoidCallback function) {
//     final collectionLogic = Provider.of<CollectionData>(context);
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextFormField(
//             //onChanged: (){}
//             keyboardType: TextInputType.text,
//             controller: control,
//             //initialValue: autoAddress,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter some text';
//               }
//               return null;
//             },
//             decoration: InputDecoration(
//               hintText: hintText,
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//               contentPadding:
//                   const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide:
//                     const BorderSide(color: Color.fromARGB(255, 214, 214, 214)),
//                 gapPadding: 10,
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide: BorderSide(color: CustomColors().blue),
//                 gapPadding: 10,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
}
