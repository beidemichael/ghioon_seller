import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Service/userDatabase.dart';
import 'package:provider/provider.dart';

import 'addProduct.dart';

class AddProductProvider extends StatefulWidget {
  const AddProductProvider({super.key});

  @override
  State<AddProductProvider> createState() => _AddProductProviderState();
}

class _AddProductProviderState extends State<AddProductProvider> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAuth?>(context);
    return StreamProvider<List<UserInformation>>.value(
        value: UserDatabaseService(userUid: user?.uid).userInfo,
        initialData: [],
        child: AddProduct());
  }
}
