import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/Product_components/components.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/addProduct.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/allProducts.dart';
import 'package:provider/provider.dart';

class AddProductMan extends StatefulWidget {
  const AddProductMan({super.key});

  @override
  State<AddProductMan> createState() => _AddProductManState();
}

class _AddProductManState extends State<AddProductMan> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => RangeData(), child: AddProduct());
  }
}
