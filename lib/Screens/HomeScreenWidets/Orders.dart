// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../Shared/customColors.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    const upperTab =
        TabBar(indicatorColor: Colors.white, indicatorWeight: 3, tabs: <Tab>[
      Tab(
        child: Text('All Orders',
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontWeight: FontWeight.w500)),
      ),
      Tab(
        child: Text('Pending',
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontWeight: FontWeight.w500)),
      ),
      Tab(
        child: Text('Cancelled',
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontWeight: FontWeight.w500)),
      ),
      Tab(
        child: Text('Completed',
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontWeight: FontWeight.w500)),
      ),
    ]);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // const Text('Orders',
                //     style: TextStyle(
                //         fontSize: 21.0,
                //         color: Colors.white,
                //         fontWeight: FontWeight.w600)),
              ],
            ),
            excludeHeaderSemantics: true,
            backgroundColor: CustomColors().blue,
            elevation: 3,
            bottom: upperTab,
            iconTheme: const IconThemeData(color: Colors.white)),
        body: TabBarView(
          children: [
            EmptyScreen(context,'No orders yet.'),
            EmptyScreen(context,'No pending orders yet.'),
            EmptyScreen(context,'No cancelled orders yet.'),
            EmptyScreen(context,'No completed orders yet.'),
          ],
        ),
      ),
    );
  }
}

Widget EmptyScreen(BuildContext context, text) {
  return Container(
    color: Colors.white,
    height: MediaQuery.of(context).size.height,
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/undraw_No_data_re_kwbl.png',
            height: MediaQuery.of(context).size.height * .3,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(text,
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    ),
  );
}

class ordersWidget extends StatelessWidget {
  const ordersWidget({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 0),
      child: Container(
        height: width / 2.8,
        decoration: BoxDecoration(
          border: Border.all(
              width: 1, color: const Color.fromARGB(255, 224, 224, 224)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: ListTile(
              title: Text(
                "BeatsStudio3",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24,
                    color: CustomColors().grey,
                    fontWeight: FontWeight.w700),
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.asset('assets/images/head.png',
                    // width: 60,
                    //height: 150,
                    fit: BoxFit.fill),
              ), //Image.asset('assets/images/head.png'),
              subtitle: Row(
                children: [
                  Text(
                    "#F3GH4785469",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: CustomColors().grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  Text("."),
                  Text("2 hr ago",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          color: CustomColors().grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600))
                ],
              ),
              trailing: Text("ETB 1800",
                  style: TextStyle(
                      fontFamily: 'Inter',
                      color: CustomColors().black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: const Color.fromARGB(255, 224, 224, 224)),
                    color: Color.fromARGB(54, 178, 92, 92),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 8.0, 15, 8),
                    child: Text(
                      "Pending",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: CustomColors().red),
                    ),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: const Color.fromARGB(255, 224, 224, 224)),
                      color: Color.fromARGB(72, 107, 107, 107),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        "Abebe Kebede",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: CustomColors().black),
                      ),
                    )),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: const Color.fromARGB(255, 224, 224, 224)),
                    color: Color.fromARGB(72, 107, 107, 107),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 8.0, 15, 8),
                    child: Text(
                      "Lafto",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: CustomColors().black),
                    ),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
