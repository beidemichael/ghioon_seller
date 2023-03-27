// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../home.dart';

class PendingScreen extends StatelessWidget {
  const PendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/undraw_Order_confirmed_re_g0if.png',
              width: MediaQuery.of(context).size.width,
            ),
          ),
          const Text('Thank you for submitting',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Color.fromARGB(255, 156, 156, 156),
                  fontWeight: FontWeight.w400)),
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const HomeScreen()),
              // );
            },
            child: const Text('Pending for Approval...',
                style: TextStyle(
                    fontSize: 30.0,
                    color: Color.fromARGB(255, 133, 133, 133),
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
