// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ghioon_seller/Screens/SignIn/BecomeSeller.dart';
import 'package:ghioon_seller/Service/categoryDatabase.dart';
import 'package:provider/provider.dart';

import '../Models/models.dart';
import 'SignIn/PendingScreen.dart';
import 'home.dart';

class CheckRegisteration extends StatelessWidget {
  const CheckRegisteration({super.key});

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserInformation>>(context);

    return Scaffold(
      // ignore: unnecessary_null_comparison
      body: userInfo == null
          ? const Center(
              child: SpinKitCircle(
              color: Colors.black,
              size: 50.0,
            ))
          : userInfo.isEmpty
              ?  
              StreamProvider<List<Categories>>.value(
                value: CategoryDatabaseService().categories,
                initialData: const [],
                catchError: (_, __) => [],
                child:  BecomeSeller())
              
              : userInfo[0].approved
                  ? const HomeScreen()
                  : const PendingScreen(),
    );
  }
}
