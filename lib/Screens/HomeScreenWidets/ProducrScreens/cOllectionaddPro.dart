import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/collections.dart';
import 'package:ghioon_seller/Service/userDatabase.dart';
import 'package:provider/provider.dart';

class CollectionProvider extends StatefulWidget {
  const CollectionProvider({super.key});

  @override
  State<CollectionProvider> createState() => _CollectionProviderState();
}

class _CollectionProviderState extends State<CollectionProvider> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAuth?>(context);
    return StreamProvider<List<UserInformation>>.value(
        value: UserDatabaseService(userUid: user?.uid).userInfo,
        initialData: [],
        child: Collections());
  }
}
