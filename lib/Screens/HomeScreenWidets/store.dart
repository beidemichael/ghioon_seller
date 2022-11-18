// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../Shared/customColors.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    // List of items in our dropdown menu
    var items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
    ];
    String dropdownvalue = 'Item 1';
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                  Text('Store',
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
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                  width: width,
                  height: height * 0.16,
                  decoration: BoxDecoration(
                      color: CustomColors().blue,
                      border: Border.all(
                        color: CustomColors().blue,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // ignore: prefer_const_literals_to_create_immutables
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Row(
                                children: [
                                  Text("My Store",
                                      style: TextStyle(
                                          fontSize: 30.0,
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  Icon(
                                    Icons.arrow_downward,
                                    color: CustomColors().white,
                                    size: 28,
                                  )
                                ],
                              ),
                              Text("Endale Abegaz",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300)),
                              Text("Id: G1547856",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300))

                              // DropdownButton(
                              //   // Initial Value
                              //   value: dropdownvalue,

                              //   // Down Arrow Icon
                              //   icon: const Icon(Icons.keyboard_arrow_down),

                              //   // Array list of items
                              //   items: items.map((String items) {
                              //     return DropdownMenuItem(
                              //       value: items,
                              //       child: Text(items),
                              //     );
                              //   }).toList(),
                              //   // After selecting the desired option,it will
                              //   // change button value to selected value
                              //   onChanged: (String? newValue) {
                              //     setState(() {
                              //       dropdownvalue = newValue!;
                              //     });
                              //   },
                              // ),
                            ]),
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
