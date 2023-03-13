import 'package:flutter/material.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/OrdersScreens/OrdersWidgets/OrdersDetail.dart';
import 'package:provider/provider.dart';

import '../../../Models/models.dart';
import '../../../Shared/constants.dart';
import '../../../Shared/customColors.dart';
import '../../components/emptyScreen.dart';
import 'OrdersWidgets/OrdersCard.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<Orders>>(context);
    return Container(
      child: orders.isNotEmpty
          ? Container(
              height: ScreenSize().ScreenHeight(context) * 0.55,
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  OrdersDetail(orders: orders[index],)),
                      );
                    },
                    child: OrdersCard(
                      orders: orders[index],
                    ),
                  );
                },
              ),
            )
          : Container(
              height: ScreenSize().ScreenHeight(context),
              child: EmptyScreen(context, 'No orders yet.'),
            ),
    );
  }
}
