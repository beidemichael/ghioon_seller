// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Screens/SignIn/BecomeSeller.dart';
import 'package:ghioon_seller/Service/Product/readProduct.dart';
import 'package:ghioon_seller/Service/Category/categoryDatabase.dart';
import 'package:ghioon_seller/Service/lastId.dart';
import 'package:ghioon_seller/Service/userDatabase.dart';
import 'package:provider/provider.dart';

import '../Service/Collection/readCollection.dart';
import 'SignIn/PendingScreen.dart';
import 'home.dart';

class CheckRegisteration extends StatelessWidget {
  const CheckRegisteration({super.key});

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserInformation>>(context);
    final user = Provider.of<UserAuth?>(context);

    return Container(
      // ignore: unnecessary_null_comparison
      child: userInfo == null
          ? const Center(
              child: SpinKitCircle(
              color: Colors.black,
              size: 50.0,
            ))
          : userInfo.isEmpty
              ? StreamProvider<List<Categories>>.value(
                  value: CategoryDatabaseService().categories,
                  initialData: const [],
                  catchError: (_, __) => [],
                  child: StreamProvider<List<LastId>>.value(
                      value: LastIdService().lastId,
                      initialData: const [],
                      catchError: (_, __) => [],
                      child: BecomeSeller()))
              : userInfo[0].approved
                  ? MultiProvider(providers: [
                      StreamProvider<List<Product>>.value(
                        initialData: [],
                        value: ReadProductDatabaseService(
                                userUid: FirebaseAuth.instance.currentUser!.uid)
                            .readProduct,
                      ),
                      StreamProvider<List<Collection>>.value(
                        initialData: [],
                        value: ReadCollectionDatabaseService(
                                userUid: FirebaseAuth.instance.currentUser!.uid)
                            .readCollection,
                      ),
                      StreamProvider<List<UserInformation>>.value(
                        initialData: [],
                        value: UserDatabaseService(userUid: user?.uid).userInfo,
                      ),
                    ], child: const HomeScreen())
                  : const PendingScreen(),
    );
  }
}
