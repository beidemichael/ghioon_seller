import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Screens/components/BlueButton.dart';
import 'package:ghioon_seller/Service/Category/AddCategoryDatabase.dart';
import 'package:ghioon_seller/Shared/dimensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  bool categoryOpen = false;
  int businessCategory = 10000;
  List<String> businessType = [];
  bool businessTypeValid = true;
 bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<List<Categories>>(context);
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.all(Dimensions.width10),
        child: ListView(children: [
           Image.asset(
                    'assets/undraw_Social_bio_re_0t9u.png',
                    height: MediaQuery.of(context).size.height * .4,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
           GestureDetector(
                      onTap: () {
                        setState(() {
                          categoryOpen = !categoryOpen;
                        });
                      },
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal:  Dimensions.width10),
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
                                               // businessType =categories[index].type;
                                                if(businessType.contains(categories[index].type)){
                                                  businessType.remove(categories[index].type);
                                                }
                                                else{
                                                  businessType.add(categories[index].type);
                                                }
                                                print(businessType);
                                                
                                              });
                                            },
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color:
                                                // businessCategory == index
                                                 businessType.contains(categories[index].type)
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


                          
                        
                          setState(() {
                            isLoading = true;
                            if (businessType.isEmpty) {
                              businessTypeValid = false;
                            } else {
                              businessTypeValid = true;
                            }
                          });
                          if (businessType.isNotEmpty) {
                           
                              final user = FirebaseAuth.instance.currentUser;
                              final phoneNumber = user!.phoneNumber;
                              final userUid = user.uid;

                              await AddCategoryDatabase().addCategory(businessType, userUid);
                               Navigator.of(context).pop();
                              
                            
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
                            : BlueButton(text: 'Add Category')),
        ],),
      ),
    );
  }
}