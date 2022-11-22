import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/addProduct.dart';
import 'package:ghioon_seller/Shared/constants.dart';
import 'package:ghioon_seller/Shared/customColors.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({super.key});

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddProduct()),
                    );
                  },
                  child: Center(
                    child: Icon(
                      FontAwesomeIcons.plus,
                      size: 25.0,
                      color: CustomColors().white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
              centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text('All Products',
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
              iconTheme: const IconThemeData(color: Colors.white)),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 0),
          child: ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                ProductList(
                    title: "BeatsStudio3",
                    stock: "22 Available",
                    image: 'assets/images/head.png'),
                ProductList(
                    title: "BeatsStudio3",
                    stock: "22 Available",
                    image: 'assets/images/head.png'),
                ProductList(
                    title: "BeatsStudio3",
                    stock: "22 Available",
                    image: 'assets/images/head.png')
              ]),
        ));
  }
}

class ProductList extends StatelessWidget {
  const ProductList(
      {Key? key, required this.title, required this.stock, required this.image})
      : super(key: key);

  final String title;
  final String stock;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Container(
        height: ScreenSize().ScreenWidth(context) / 3.5,
        decoration: BoxDecoration(
          border: Border.all(
              width: 1, color: const Color.fromARGB(255, 224, 224, 224)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: ListTile(
            title: Text(
              "BeatsStudio3",
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24,
                  color: CustomColors().blue,
                  fontWeight: FontWeight.w700),
            ),
            leading: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.asset(image,
                  // width: 60,
                  //height: 150,
                  fit: BoxFit.fill),
            ), //Image.asset('assets/images/head.png'),

            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.penToSquare),
              iconSize: 40,
              color: CustomColors().blue,
            ),

            subtitle: Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Row(
                children: [
                  Text(
                    stock,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: CustomColors().black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  const Text("."),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
