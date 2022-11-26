import 'package:flutter/material.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Screens/CheckRegisteration.dart';

import 'package:provider/provider.dart';

import '../Service/userDatabase.dart';
import 'SignIn/SignInPage.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAuth?>(context);

    return StreamProvider<List<UserInformation>>.value(
        value: UserDatabaseService(userUid: user?.uid).userInfo,
        initialData: const [],
        child: user == null ? SignInPage() : const CheckRegisteration());
  }
}
