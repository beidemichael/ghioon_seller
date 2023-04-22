import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ghioon_seller/Providers/AppState.dart';
import 'package:ghioon_seller/Providers/EditProfileProvider.dart';
import 'package:ghioon_seller/Providers/MapProvider.dart';
import 'package:ghioon_seller/Providers/CollectionProvider.dart';
import 'package:ghioon_seller/Providers/FeedbackProvider.dart';
import 'package:ghioon_seller/Providers/language_provider.dart';
import 'package:ghioon_seller/Service/Category/categoryDatabase.dart';
import 'package:ghioon_seller/Service/Collection/readCollection.dart';
import 'package:ghioon_seller/Service/Collection/readCollectionItems.dart';
import 'package:ghioon_seller/Service/Product/readProduct.dart';
import 'package:ghioon_seller/Service/userDatabase.dart';
import 'package:ghioon_seller/firebase_options.dart';
import 'package:provider/provider.dart';

import 'Models/models.dart';
import 'Providers/EditRangeProvider.dart';
import 'Providers/RangeProvider.dart';
import 'Screens/update/forced_update.dart';
import 'Screens/update/optional_update.dart';
import 'Screens/wrapper.dart';
import 'Service/Controller/Controller.dart';
import 'Service/Orders/OrdersDatabase.dart';
import 'Service/auth.dart';
import 'Shared/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Firebase.apps;

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamProvider<UserAuth?>.value(
        value: AuthServices().user,
        initialData: null,
        child: Builder(builder: (context) {
          final user = Provider.of<UserAuth?>(context);
          return user == null
              ? MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (context) => LanguageProvider(),
                    ),
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
                    StreamProvider<List<Controller>>.value(
                      initialData: [],
                      value: ControllerDatabaseService().controller,
                    ),
                    StreamProvider<List<Categories>>.value(
                      initialData: [],
                      value: CategoryDatabaseService().categories,
                    ),
                  ],
                  child: const MyApp(),
                )
              : MultiProvider(
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
                        initialData: [],
                        create: (_) {
                          final userUid =
                              FirebaseAuth.instance.currentUser?.uid;
                          return ReadProductDatabaseService(userUid: userUid)
                              .readProduct;
                        }),
                    StreamProvider<List<Collection>>(
                        initialData: [],
                        create: (_) {
                          final userUid =
                              FirebaseAuth.instance.currentUser?.uid;
                          return ReadCollectionDatabaseService(userUid: userUid)
                              .readCollection;
                        }),
                    StreamProvider<List<UserInformation>>(
                        initialData: [],
                        create: (_) {
                          final userUid =
                              FirebaseAuth.instance.currentUser?.uid;
                          return UserDatabaseService(userUid: userUid).userInfo;
                        }),
                    StreamProvider<List<Controller>>(
                        initialData: [],
                        create: (_) {
                          return ControllerDatabaseService().controller;
                        }),
                    ChangeNotifierProvider(
                      create: (context) => LanguageProvider(),
                    ),
                    StreamProvider<List<Categories>>.value(
                      initialData: [],
                      value: CategoryDatabaseService().categories,
                    ),
                  ],
                  child: const MyApp(),
                );
        }),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ///////////////////
  int netVersion = 0;

  /////////////////////////// App version
  int appVersion = 12;

  //////////////////////////  App version
  ///
  optionalUpdateActivator(BuildContext context, netVersionInput) {
    if (netVersionInput == 3 || netVersionInput == 4) {
      OptionalUpdate alert = OptionalUpdate();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      // optionalUpdateActivator(context, netVersion);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<List<Controller>>(context);
    if (controller.isNotEmpty) {
      netVersion = controller[0].sellerVersion - appVersion;
      print('netVersion: ' + netVersion.toString());
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: controller.isEmpty
          ? Loading()
          : Scaffold(
              body: Stack(
                children: [
                  const Wrapper(),
                  Visibility(
                    visible: netVersion > 4,
                    child: ForcedUpdate(),
                  ),
                ],
              ),
            ),
    );
  }
}
