import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Screens/CheckRegisteration.dart';
import 'package:ghioon_seller/Screens/update/optional_update.dart';
import 'package:provider/provider.dart';
import '../Service/userDatabase.dart';
import '../Shared/loading.dart';
import 'SignIn/SignInPage.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAuth?>(context);
    return StreamProvider<List<UserInformation>>.value(
        value: UserDatabaseService(userUid: user?.uid).userInfo,
        initialData: [],
        child: user == null ? SignInPage() : const CheckRegisteration());
  }
}
