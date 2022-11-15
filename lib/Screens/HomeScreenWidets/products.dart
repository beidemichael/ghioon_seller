import 'package:flutter/material.dart';

import '../../Shared/customColors.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text('Products',
                    style: TextStyle(
                        fontSize: 30.0,
                        // ignore: prefer_const_literals_to_create_immutables
                        // shadows: <Shadow>[
                        //   const Shadow(
                        //     offset: Offset(0.0, 4.0),
                        //     blurRadius: 3.0,
                        //     color: Color.fromARGB(255, 190, 190, 190),
                        //   ),
                        // ],
                        color: Colors.white,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            // excludeHeaderSemantics: true,
            backgroundColor: CustomColors().blue,
            // automaticallyImplyLeading: false,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            iconTheme: IconThemeData(color: Colors.white)),
      ),
    );
  }
}
