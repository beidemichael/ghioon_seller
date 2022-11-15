import 'package:flutter/material.dart';

import '../../Shared/customColors.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       drawer: Container(),
      appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text('Dashboard',
                  style: TextStyle(
                      fontSize: 30.0,
                      // ignore: prefer_const_literals_to_create_immutables
                      shadows: <Shadow>[
                        const Shadow(
                          offset: Offset(0.0, 4.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 190, 190, 190),
                        ),
                      ],
                      color: CustomColors().blue,
                      fontWeight: FontWeight.w700)),
            ],
          ),
          // excludeHeaderSemantics: true,
          backgroundColor: Colors.grey[50],
          // automaticallyImplyLeading: false,
          elevation: 0,
          iconTheme: IconThemeData(color: CustomColors().blue)),
    );
  }
}