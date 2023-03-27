// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Providers/language_provider.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/Orders.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/dashboard.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/products.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/store.dart';
import 'package:ghioon_seller/Screens/update/optional_update.dart';
import 'package:ghioon_seller/Shared/language.dart';
import 'package:ghioon_seller/Shared/loading.dart';
import 'package:provider/provider.dart';

import '../Shared/customColors.dart';
import 'update/forced_update.dart';

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

  ///////////////////
  int netVersion = 0;
  /////////////////////////// App version
  int appVersion = 1;
  //////////////////////////  App version
  ///
  optionalUpdateActivator(BuildContext context, netVersionInput) {
    if (netVersionInput == 3 || netVersionInput == 4) {
      OptionalUpdate alert = OptionalUpdate();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      optionalUpdateActivator(context, netVersion);
    });
  }

  @override
  Widget build(BuildContext context) {
    var languageprov = Provider.of<LanguageProvider>(context);
    final controller = Provider.of<List<Controller>>(context);
    if (controller.isNotEmpty) {
      netVersion = controller[0].sellerVersion - appVersion;
    }

    return controller.isEmpty
        ? Loading()
        : Scaffold(
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
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.grip),
                  label: Language().dashboard[languageprov.LanguageIndex],
                ),
                // const BottomNavigationBarItem(
                //   icon: Icon(FontAwesomeIcons.cartShopping),
                //   label: 'Orders',
                // ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.tag),
                  label: Language().products[languageprov.LanguageIndex],
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.store),
                  label: Language().store[languageprov.LanguageIndex],
                ),
              ],
            ),
            body: Stack(
              children: [
                PageView(
                  controller: _pageViewController,
                  children: const <Widget>[
                    Dashboard(),
                    // OrdersScreen(),
                    Products(),
                    Store()
                  ],
                  onPageChanged: (index) {
                    setState(() {
                      _activePage = index;
                    });
                  },
                ),
                Visibility(
                  visible: netVersion > 4,
                  child: ForcedUpdate(),
                ),
              ],
            ),
          );
  }
}
