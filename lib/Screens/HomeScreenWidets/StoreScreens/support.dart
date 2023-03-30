import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Screens/components/SnackBar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Shared/customColors.dart';

class Support extends StatelessWidget {
  Support({super.key});
  List<IconData> support = [
    FontAwesomeIcons.whatsapp,
    FontAwesomeIcons.envelopeOpenText,
    FontAwesomeIcons.phone,
    FontAwesomeIcons.telegram,
  ];

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        contentPadding: const EdgeInsets.all(0),
        content: SizedBox(
          width: 250.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Help and Support",
                    style: TextStyle(
                        fontSize: 24.0,
                        color: CustomColors().blue,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Divider(
                color: CustomColors().blue,
                height: 4.0,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 25.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          try {
                            print("Launch URL: whatsapp://send?phone=");
                            if (!await launchUrl(
                                Uri.parse(
                                    "whatsapp://send?phone=+251940679413"),
                                mode: LaunchMode.externalApplication)) {
                              snackBar(context, 'Something went wrong',
                                  CustomColors().blue, Colors.white);
                            }
                          } catch (ex) {
                            print("Could not launch url $ex");
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 80,
                            decoration: BoxDecoration(
                              color: CustomColors().superLightBlue,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.lightBlue.withOpacity(0.5),
                                  spreadRadius: 0.05,
                                  blurRadius: 3,
                                  offset: const Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Center(
                              child: Icon(
                                FontAwesomeIcons.whatsapp,
                                color: CustomColors().blue,
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final mailtoUri = Uri(
                            scheme: 'mailto',
                            path: 'ghioonofficial@gmail.com',
                          );
                          await launchUrl(mailtoUri);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 80,
                            decoration: BoxDecoration(
                              color: CustomColors().superLightBlue,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.lightBlue.withOpacity(0.5),
                                  spreadRadius: 0.05,
                                  blurRadius: 3,
                                  offset: const Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Center(
                              child: Icon(
                                FontAwesomeIcons.envelopeOpenText,
                                color: CustomColors().blue,
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          // launch("tel://${'+251940679413'}");
                          final Uri launchUri = Uri(
                            scheme: 'tel',
                            path: '+251940679413',
                          );

                          await launchUrl(launchUri);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 80,
                            decoration: BoxDecoration(
                              color: CustomColors().superLightBlue,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.lightBlue.withOpacity(0.5),
                                  spreadRadius: 0.05,
                                  blurRadius: 3,
                                  offset: const Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Center(
                              child: Icon(
                                FontAwesomeIcons.phone,
                                color: CustomColors().blue,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          try {
                            print("Launch URL: https://t.me/gihonshopping");
                            if (!await launchUrl(
                                Uri.parse('https://t.me/gihonshopping'),
                                mode: LaunchMode.externalApplication)) {
                              snackBar(context, 'Something went wrong',
                                  CustomColors().blue, Colors.white);
                            }
                          } catch (ex) {
                            print("Could not launch url $ex");
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 80,
                            decoration: BoxDecoration(
                              color: CustomColors().superLightBlue,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.lightBlue.withOpacity(0.5),
                                  spreadRadius: 0.05,
                                  blurRadius: 3,
                                  offset: const Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Center(
                              child: Icon(
                                FontAwesomeIcons.telegram,
                                color: CustomColors().blue,
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
