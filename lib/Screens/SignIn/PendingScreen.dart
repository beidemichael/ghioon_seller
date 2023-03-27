// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ghioon_seller/Providers/language_provider.dart';
import 'package:ghioon_seller/Shared/language.dart';
import 'package:provider/provider.dart';
import '../home.dart';

class PendingScreen extends StatelessWidget {
  const PendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var languageprov = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/undraw_Order_confirmed_re_g0if.png',
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Text(Language().Thank_you[languageprov.LanguageIndex],
              style: TextStyle(
                  fontSize: 20.0,
                  color: Color.fromARGB(255, 156, 156, 156),
                  fontWeight: FontWeight.w400)),
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const HomeScreen()),
              // );
            },
            child: Text(Language().pending[languageprov.LanguageIndex],
                style: TextStyle(
                    fontSize: 30.0,
                    color: Color.fromARGB(255, 133, 133, 133),
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
