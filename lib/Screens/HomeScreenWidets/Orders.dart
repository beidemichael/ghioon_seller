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
    const upperTab = TabBar(
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        tabs: <Tab>[
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
        drawer: Container(),
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
            Center(
              child: Container(
              color: Colors.grey[100],
            )
            ),
            Center(
              child: Container(color: Colors.grey[200],)
            ),
             Center(
                child: Container(
              color: Colors.grey[100],
            )),
             Center(
                child: Container(
              color: Colors.grey[200],
            )),
          ],
        ),
      ),
    );
  }
}
