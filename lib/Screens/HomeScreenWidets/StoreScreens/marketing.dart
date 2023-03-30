import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Providers/language_provider.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/StoreScreens/Marketing/MarketingUploadScreen.dart';
import 'package:ghioon_seller/Shared/language.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../Shared/customColors.dart';

class Marketing extends StatefulWidget {
  const Marketing({super.key});

  @override
  State<Marketing> createState() => _MarketingState();
}

class _MarketingState extends State<Marketing> {
  bool promotionType = true;
  changePromotionType() {
    setState(() {
      promotionType = !promotionType;
      // if (index == 0) {
      //   promotionType = true;
      // } else {
      //   promotionType = false;
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    var languageprov = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(69.0),
        child: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(Language().marketing[languageprov.LanguageIndex],
                    style: TextStyle(
                        fontSize: 30.0,
                        color: CustomColors().white,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            // excludeHeaderSemantics: true,
            backgroundColor: CustomColors().blue,
            // automaticallyImplyLeading: false,
            elevation: 5,
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
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 80),
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(Language().choose[languageprov.LanguageIndex],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'IBMPlexSans',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: CustomColors().blue,
                      )),
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Switch(
                            (MediaQuery.of(context).size.width - 50) * .5,
                            MediaQuery.of(context).size.width * .5,
                            promotionType
                                ? Language().image[languageprov.LanguageIndex]
                                : Language().video[languageprov.LanguageIndex],
                            Language().promotype[languageprov.LanguageIndex] +
                                ':'),
                        const SizedBox(
                          height: 10,
                        ),
                        container(
                            (MediaQuery.of(context).size.width - 50) * .5,
                            MediaQuery.of(context).size.width * .5,
                            Language().promotion[languageprov.LanguageIndex],
                            '25% SCREEN REALESTATE',
                            25),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    container(
                        (MediaQuery.of(context).size.width - 50) * .5,
                        MediaQuery.of(context).size.width + 10,
                        Language().promotion[languageprov.LanguageIndex],
                        '100% SCREEN REALESTATE',
                        100),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                container(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.width * .5,
                    Language().promotion[languageprov.LanguageIndex],
                    '50% SCREEN REALESTATE',
                    50),
                Container(
                  height: 50,
                ),
              ],
            ),
          ),
          Positioned(
            top: -70,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  // border: Border.all(width: 1, color: CustomColors().blue),
                  color: CustomColors().white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.05,
                      blurRadius: 3,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const SizedBox(
                    //   height: 15,
                    // ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Text(
                          Language().promotproduct[languageprov.LanguageIndex],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: CustomColors().grey,
                              fontWeight: FontWeight.w400)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget container(double width, double height, String title, String subTitle,
      int screenRealestate) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MarketingUploadScreen(
                  imagType: promotionType, screenRealestate: screenRealestate)),
        );
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          // border: Border.all(width: 1, color: CustomColors().blue),
          color: CustomColors().superLightBlue,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.lightBlue.withOpacity(0.5),
              spreadRadius: 0.05,
              blurRadius: 3,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const SizedBox(
            //   height: 15,
            // ),

            Text(subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: CustomColors().blue,
                    fontWeight: FontWeight.w300)),
            Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 25,
                    color: CustomColors().blue,
                    fontWeight: FontWeight.w700)),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget Switch(double width, double height, String title, String subTitle) {
    var languageprov = Provider.of<LanguageProvider>(context);
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        // border: Border.all(width: 1, color: CustomColors().blue),
        color: CustomColors().white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.lightBlue.withOpacity(0.5),
            spreadRadius: 0.05,
            blurRadius: 3,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const SizedBox(
                //   height: 15,
                // ),

                Text(subTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: CustomColors().grey,
                        fontWeight: FontWeight.w300)),
                AnimatedContainer(
                  // height: 90,
                  // width: 75,
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.bounceInOut,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                  ),
                  child: Text(
                      promotionType
                          ? Language().image[languageprov.LanguageIndex]
                          : Language().video[languageprov.LanguageIndex],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 25,
                          color: CustomColors().grey,
                          fontWeight: FontWeight.w700)),
                ),

                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          promotionType = true;
                        });
                      },
                      child: AnimatedContainer(
                        height: 90,
                        width: 75,
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.bounceInOut,
                        decoration: BoxDecoration(
                          color: promotionType
                              ? CustomColors().blue
                              : Colors.grey.shade200,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15)),
                        ),
                        child: const Icon(
                          FontAwesomeIcons.image,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          promotionType = false;
                        });
                      },
                      child: AnimatedContainer(
                        height: 90,
                        width: 75,
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.bounceInOut,
                        decoration: BoxDecoration(
                          color: !promotionType
                              ? CustomColors().blue
                              : Colors.grey.shade200,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                        ),
                        child: const Icon(
                          FontAwesomeIcons.video,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
