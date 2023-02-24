import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ghioon_seller/Providers/AppState.dart';
import 'package:ghioon_seller/Providers/EditProfileProvider.dart';
import 'package:ghioon_seller/Providers/MapProvider.dart';
import 'package:ghioon_seller/Providers/CollectionProvider.dart';
import 'package:ghioon_seller/Providers/FeedbackProvider.dart';
import 'package:ghioon_seller/Service/Collection/readCollection.dart';
import 'package:ghioon_seller/Service/Collection/readCollectionItems.dart';
import 'package:ghioon_seller/Service/Product/readProduct.dart';
import 'package:ghioon_seller/Service/userDatabase.dart';
import 'package:ghioon_seller/firebase_options.dart';
import 'package:provider/provider.dart';

import 'Models/models.dart';
import 'Providers/EditRangeProvider.dart';
import 'Providers/RangeProvider.dart';
import 'Screens/wrapper.dart';
import 'Service/Controller/Controller.dart';
import 'Service/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Firebase.apps;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => RangeData(),
          ),
          ChangeNotifierProvider(
            create: (context) => EditRangeData(),
          ),
          ChangeNotifierProvider(
            create: (context) => EditProfileData(),
          ),
          ChangeNotifierProvider(
            create: (context) => MapProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => CollectionData(),
          ),
          ChangeNotifierProvider(
            create: (context) => FeedbackData(),
          ),
          ChangeNotifierProvider(
            create: (context) => AppState(),
          ),
          StreamProvider<List<Product>>(
            create: (_) {
              final userUid = FirebaseAuth.instance.currentUser?.uid;
              return ReadProductDatabaseService(userUid: userUid).readProduct;
            },
            initialData: [],
          ),
          StreamProvider<List<Collection>>(
            create: (_) {
              final userUid = FirebaseAuth.instance.currentUser?.uid;
              return ReadCollectionDatabaseService(userUid: userUid)
                  .readCollection;
            },
            initialData: [],
          ),
          StreamProvider<List<UserInformation>>(
            create: (_) {
              final userUid = FirebaseAuth.instance.currentUser?.uid;
              return UserDatabaseService(userUid: userUid).userInfo;
            },
            initialData: [],
          ),
          // StreamProvider<List<Controller>>.value(
          //   initialData: [],
          //   value: ControllerDatabaseService().controller,
          // ),
          StreamProvider<List<Controller>>(
            initialData: [],
            create:(_){
return ControllerDatabaseService().controller;
            }
            
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StreamProvider<UserAuth?>.value(
          value: AuthServices().user,
          initialData: null,
          child: const Wrapper(),
        ),
      ),
    );
  }
}
