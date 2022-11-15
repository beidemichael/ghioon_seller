// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/dashboard.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/products.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/store.dart';

import '../Shared/customColors.dart';
import 'HomeScreenWidets/Orders.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageViewController = PageController();

  int _activePage = 0;

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        iconSize: 25,
        selectedLabelStyle: TextStyle(
            fontSize: 13.0,
            color: CustomColors().blue,
            fontWeight: FontWeight.w600),
        elevation: 5,
        selectedItemColor: CustomColors().blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _activePage,
        onTap: (index) {
          _pageViewController.animateToPage(index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.bounceOut);
        },
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.grip),
            label: 'Dashboard',
          ),
          const BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.cartShopping),
            label: 'Orders',
          ),
          const BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.tag),
            label: 'Products',
          ),
          const BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.store),
            label: 'Store',
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView(
            controller: _pageViewController,
            children: const <Widget>[Dashboard(), Orders(), Products(), Store()],
            onPageChanged: (index) {
              setState(() {
                _activePage = index;
              });
            },
          ),
        ],
      ),
    );
  }
}
