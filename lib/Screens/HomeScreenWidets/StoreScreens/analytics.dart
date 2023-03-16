import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../Models/models.dart';
import '../../../Shared/customColors.dart';
import '../../../Shared/loading.dart';
import '../ProductScreens/graph/piechart.dart';
import '../dashboardScreens/CustomBarChart/BarChart.dart';
import 'Analytics/CollectionPiechart.dart';

class Analytics extends StatelessWidget {
  const Analytics({super.key});

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserInformation>>(context);
    return userInfo.isEmpty
        ? Loading()
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: AppBar(
                  centerTitle: true,
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text('Analytics',
                          style: TextStyle(
                              fontSize: 30.0,
                              color: CustomColors().white,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                  // excludeHeaderSemantics: true,
                  backgroundColor: CustomColors().blue,
                  // automaticallyImplyLeading: false,
                  elevation: 5,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  iconTheme: IconThemeData(color: CustomColors().white)),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  SizedBox(
                      height: 700,
                      child: BarChartSample3(views: userInfo[0].viewsTime)),
                  const SizedBox(
                      width: 400, height: 500, child: CollectionPieChartChart())
                ],
              ),
            ),
          );
  }
}
