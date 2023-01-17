// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ghioon_seller/Shared/customColors.dart';
import 'package:ghioon_seller/Shared/loading.dart';
import 'package:provider/provider.dart';

import '../../../../../Models/models.dart';
import 'addProfileImageContainer.dart';
import 'addProfileVideoContainer.dart';

class ProfileImageAndVideoBlurryDialog extends StatelessWidget {
  TextStyle textStyle = const TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserInformation>>(context);
    return userInfo.isEmpty
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.transparent,
            body: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  contentPadding: const EdgeInsets.all(0),
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
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
                              "Profile",
                              style: TextStyle(
                                  fontSize: 24.0,
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        const Divider(
                          color: Colors.grey,
                          height: 4.0,
                        ),
                        Center(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 25.0),
                              child: ListView(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  children: [
                                    const SizedBox(height: 20),
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                7,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: const Color.fromARGB(
                                                  255, 207, 207, 207)),
                                          color: CustomColors().white,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Center(
                                            child: AddProfileImageContainer())),
                                    const SizedBox(height: 15),
                                    const SizedBox(height: 15),
                                    Container(
                                      height:
                                          (MediaQuery.of(context).size.width *
                                                  .5) +
                                              80,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: const Color.fromARGB(
                                                255, 207, 207, 207)),
                                        color: CustomColors().white,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Center(
                                        child: AddProfileVideoContainer(
                                          user: userInfo[0],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                  ])),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                              color: CustomColors().blue,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(30.0),
                                  bottomRight: Radius.circular(30.0)),
                            ),
                            child: const Center(
                              child: Text('OK',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          );
  }
}
