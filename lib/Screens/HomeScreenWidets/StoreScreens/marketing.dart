import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Shared/customColors.dart';

class Marketing extends StatelessWidget {
  const Marketing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(69.0),
        child: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text('Marketing',
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
            padding: const EdgeInsets.only(right: 20.0,left: 20.0,top: 80),
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text('CHOOSE YOUR TYPE BELOW',
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
                        container(
                            (MediaQuery.of(context).size.width - 50) * .5,
                            MediaQuery.of(context).size.width * .5,
                            'CUSTOMERS',
                            '25% SCREEN REALSTATE'),
                        const SizedBox(
                          height: 10,
                        ),
                        container(
                            (MediaQuery.of(context).size.width - 50) * .5,
                            MediaQuery.of(context).size.width * .5,
                            'CUSTOMERS',
                            '25% SCREEN REALSTATE'),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    container(
                        (MediaQuery.of(context).size.width - 50) * .5,
                        MediaQuery.of(context).size.width + 10,
                        'CUSTOMERS',
                        '100% SCREEN REALSTATE'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                container(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.width * .5,
                    'CUSTOMERS',
                    '50% SCREEN REALSTATE'),
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
                      child: Text('Promote your product and services here',
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

  Widget container(double width, double height, String title, String subTitle) {
    return Container(
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
    );
  }
}
