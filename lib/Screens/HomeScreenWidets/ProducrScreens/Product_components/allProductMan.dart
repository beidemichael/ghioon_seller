import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/Product_components/components.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/addProduct.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProducrScreens/allProducts.dart';
import 'package:provider/provider.dart';

class AllProductMan extends StatefulWidget {
  const AllProductMan({super.key});

  @override
  State<AllProductMan> createState() => _AllProductManState();
}

class _AllProductManState extends State<AllProductMan> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => RangeData(), child: AllProduct());
  }
}
