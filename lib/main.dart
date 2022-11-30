import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ghioon_seller/Models/MapProvider.dart';
import 'package:ghioon_seller/firebase_options.dart';
import 'package:provider/provider.dart';

import 'Models/models.dart';
import 'Providers/RangeProvider.dart';
import 'Screens/wrapper.dart';
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
            create: (context) => MapProvider(),
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
