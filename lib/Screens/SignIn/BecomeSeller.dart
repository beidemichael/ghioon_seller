// ignore_for_file: file_names, prefer_const_constructors_in_immutables, unused_element, prefer_interpolation_to_compose_strings, avoid_print, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Screens/components/BlueButton.dart';
import 'package:ghioon_seller/Service/lastId.dart';
import 'package:ghioon_seller/Service/registerDatabase.dart';
import 'package:provider/provider.dart';

class BecomeSeller extends StatefulWidget {
  BecomeSeller({super.key});

  @override
  State<BecomeSeller> createState() => _BecomeSellerState();
}

class _BecomeSellerState extends State<BecomeSeller> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  String sellerName = '';
  String businessName = '';
  String email = '';
  String businessNo = '';
  int businessCategory = 10000;
  String businessType = '';
  bool categoryOpen = false;
  bool businessTypeValid = true;

  List collections = [];
  List collection_description = [];
  List collection_images = [];

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<List<Categories>>(context);
    final lastid = Provider.of<List<LastId>>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/undraw_Social_bio_re_0t9u.png',
                    height: MediaQuery.of(context).size.height * .2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Become a Seller',
                      style: TextStyle(
                          fontSize: 38.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField('Full Name', 'sellerName', true),
                  TextField('Business Name', 'businessName', true),
                  TextField('License Number(optional)', 'businessNo', false),
                  TextField('Email(optional)', 'email', false),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        categoryOpen = !categoryOpen;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Container(
                        height: 65,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          border: Border.all(
                              width: 1.25,
                              color: const Color.fromARGB(255, 196, 196, 196)),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Select Business Type',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 20.0,
                                          color:
                                              Color.fromARGB(255, 66, 66, 66))),
                                  categoryOpen
                                      ? const Icon(
                                          FontAwesomeIcons.angleUp,
                                          size: 20.0,
                                          color: Color.fromARGB(
                                              255, 143, 143, 143),
                                        )
                                      : const Icon(
                                          FontAwesomeIcons.angleDown,
                                          size: 20.0,
                                          color: Color.fromARGB(
                                              255, 143, 143, 143),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  categoryOpen
                      ? categories.isEmpty
                          ? const SpinKitCircle(
                              color: Colors.black,
                              size: 20.0,
                            )
                          : Column(
                              children: [
                                Container(
                                  height: 10,
                                  width: MediaQuery.of(context).size.width,
                                  color:
                                      const Color.fromARGB(255, 245, 244, 244),
                                ),
                                Container(
                                  color:
                                      const Color.fromARGB(255, 245, 244, 244),
                                  height: 66 * categories.length.toDouble(),
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: categories.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 50),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              businessCategory = index;
                                              businessType =
                                                  categories[index].type;
                                            });
                                          },
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: businessCategory == index
                                                  ? const Color.fromARGB(
                                                      255, 245, 255, 152)
                                                  : const Color.fromARGB(
                                                      255, 255, 255, 255),
                                              border: Border.all(
                                                  width: 1,
                                                  color: const Color.fromARGB(
                                                      255, 206, 206, 206)),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            child: Center(
                                                child: Text(
                                                    categories[index].type,
                                                    style: const TextStyle(
                                                        fontSize: 18.0,
                                                        color: Color.fromARGB(
                                                            255, 155, 155, 155),
                                                        fontWeight:
                                                            FontWeight.w400))),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  color:
                                      const Color.fromARGB(255, 245, 244, 244),
                                ),
                              ],
                            )
                      : Container(),
                  !categoryOpen
                      ? const SizedBox(
                          height: 50,
                        )
                      : Container(),
                  businessTypeValid == false && businessCategory == 10000
                      ? Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('Please select Business type.',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromARGB(255, 255, 0, 0),
                                    fontWeight: FontWeight.w400)),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      : Container(),
                  GestureDetector(
                      onTap: () async {
                        int ghioonId = lastid[0].lastId + 1;
                        setState(() {
                          isLoading = true;
                          if (businessType == '') {
                            businessTypeValid = false;
                          } else {
                            businessTypeValid = true;
                          }
                        });
                        if (businessType != '') {
                          if (_formKey.currentState!.validate()) {
                            final user = FirebaseAuth.instance.currentUser;
                            final phoneNumber = user!.phoneNumber;
                            final userUid = user.uid;
                            RegisterDatabaseService().registerInformation(
                              sellerName,
                              businessName,
                              email,
                              businessNo,
                              businessType,
                              phoneNumber.toString(),
                              ghioonId,
                              collections,
                              collection_description,
                              collection_images,
                              userUid,
                            );
                            LastIdService().updateLastID(ghioonId);
                          }
                        }

                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: isLoading
                          ? const Center(
                              child: SpinKitCircle(
                              color: Colors.black,
                              size: 50.0,
                            ))
                          : BlueButton(text: 'Continue')),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget TextField(var label, var value, bool validate) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: TextFormField(
            onChanged: (val) {
              setState(() {
                if (value == 'sellerName') sellerName = val;
                if (value == 'businessName') businessName = val;
                if (value == 'email') email = val;
                if (value == 'businessNo') businessNo = val;
              });
            },
            validator: (val) {
              if (validate) {
                if (val!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              }
              return null;
            },
            style: TextStyle(
                color: Colors.grey[700],
                fontSize: 20.0,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(left: 20, top: 30, bottom: 10),
              labelText: label,
              focusColor: Colors.orange[900],
              labelStyle: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 20.0,
                  color: Colors.grey[800]),
              enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.grey.shade400)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.orange.shade200)),
            ),
          ),
        ),
      ],
    );
  }
}
