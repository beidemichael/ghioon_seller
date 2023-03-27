import 'package:draw_graph/models/feature.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Providers/language_provider.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/dashboardScreens/linechart.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/dashboardScreens/graphPoints.dart';
import 'package:ghioon_seller/Shared/constants.dart';
import 'package:ghioon_seller/Shared/language.dart';
import 'package:provider/provider.dart';
import 'package:draw_graph/draw_graph.dart';
import '../../Models/models.dart';
import '../../Shared/customColors.dart';
import '../../Shared/loading.dart';
import '../components/BlueDashboardGrid copy.dart';
import '../components/SnackBar.dart';
import '../components/WhiteDashboardGrid.dart';
import '../components/ShortProductGrid.dart';
import 'ProductScreens/Product/allProducts.dart';
import 'package:fl_chart/fl_chart.dart';

import 'dashboardScreens/CustomBarChart/BarChart.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Color>? gradientColors = [
    Color(0xff23b6e6),
    Color(0xff02d39a),
  ];
  Gradient grad = LinearGradient(
    // begin: Alignment.topRight,
    // end: Alignment.bottomLeft,
    colors: [
      Color(0xff23b6e6).withOpacity(0.3),
      Color(0xff02d39a).withOpacity(0.3),
    ],
  );

  Gradient linegrad = LinearGradient(
    // begin: Alignment.topRight,
    // end: Alignment.bottomLeft,
    colors: [Colors.black12, Colors.white70, Colors.white],
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var languageprov = Provider.of<LanguageProvider>(context);
    final products = Provider.of<List<Product>>(context);
    final userInfo = Provider.of<List<UserInformation>>(context);
    return userInfo.isEmpty
        ? Loading()
        : Scaffold(
            // drawer: Drawer(),
            appBar: AppBar(
                centerTitle: true,
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(Language().dashboard[languageprov.LanguageIndex],
                        style: TextStyle(
                            fontSize: 30.0,
                            // ignore: prefer_const_literals_to_create_immutables
                            shadows: <Shadow>[
                              const Shadow(
                                offset: Offset(0.0, 4.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 190, 190, 190),
                              ),
                            ],
                            color: CustomColors().blue,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
                // excludeHeaderSemantics: true,
                backgroundColor: Colors.grey[50],
                // automaticallyImplyLeading: false,
                elevation: 0,
                iconTheme: IconThemeData(color: CustomColors().blue)),
            body: ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Expanded(
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       snackBar(context, Language().no_sales[languageprov.LanguageIndex],
                          //           CustomColors().blue, CustomColors().white);
                          //     },
                          //     child: WhiteDashboardGrid(
                          //       width: width,
                          //       title: "0",
                          //       subTitle: Language().sales[languageprov.LanguageIndex],
                          //       icon: FontAwesomeIcons.chartLine,
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(
                            width: 10,
                          ),
                          // Expanded(
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       snackBar(context, Language().no_revenue[languageprov.LanguageIndex],
                          //           CustomColors().blue, CustomColors().white);
                          //     },
                          //     child: BlueDashboardGrid(
                          //       width: width,
                          //       title: "0",
                          //       subTitle: Language().revenue[languageprov.LanguageIndex],
                          //       icon: FontAwesomeIcons.coins,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AllProduct()), //AddProductProvider()),
                                );
                              },
                              child: BlueDashboardGrid(
                                width: width,
                                title: products.length.toString(),
                                subTitle: Language()
                                    .products[languageprov.LanguageIndex],
                                icon: FontAwesomeIcons.tag,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          // Expanded(
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       snackBar(context, Language().no_customers[languageprov.LanguageIndex],
                          //           CustomColors().blue, CustomColors().white);
                          //     },
                          //     child: WhiteDashboardGrid(
                          //       width: width,
                          //       title: "0",
                          //       subTitle: Language().customers[languageprov.LanguageIndex],
                          //       icon: FontAwesomeIcons.peopleGroup,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: 700,
                    child: BarChartSample3(views: userInfo[0].viewsTime)),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
  }
}
