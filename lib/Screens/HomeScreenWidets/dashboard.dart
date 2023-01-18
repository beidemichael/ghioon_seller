import 'package:draw_graph/models/feature.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/dashboardScreens/linechart.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/dashboardScreens/graphPoints.dart';
import 'package:ghioon_seller/Shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:draw_graph/draw_graph.dart';
import '../../Models/models.dart';
import '../../Shared/customColors.dart';
import '../components/BlueDashboardGrid copy.dart';
import '../components/SnackBar.dart';
import '../components/WhiteDashboardGrid.dart';
import '../components/ShortProductGrid.dart';
import 'ProductScreens/Product/allProducts.dart';
import 'package:fl_chart/fl_chart.dart';

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
    final products = Provider.of<List<Product>>(context);
    return Scaffold(
      // drawer: Drawer(),
      appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text('Dashboard',
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
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          snackBar(context, 'No Sales yet.',
                              CustomColors().blue, CustomColors().white);
                        },
                        child: WhiteDashboardGrid(
                          width: width,
                          title: "0",
                          subTitle: 'Sales',
                          icon: FontAwesomeIcons.chartLine,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          snackBar(context, 'No Revenue yet.',
                              CustomColors().blue, CustomColors().white);
                        },
                        child: BlueDashboardGrid(
                          width: width,
                          title: "0",
                          subTitle: 'Revenue',
                          icon: FontAwesomeIcons.coins,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
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
                          subTitle: 'Products',
                          icon: FontAwesomeIcons.tag,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          snackBar(context, 'No Customers yet.',
                              CustomColors().blue, CustomColors().white);
                        },
                        child: WhiteDashboardGrid(
                          width: width,
                          title: "0",
                          subTitle: 'Customers',
                          icon: FontAwesomeIcons.peopleGroup,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            //     // the first chart starts here
            //   LineGraph(
            //     features: features,
            //     size: Size(ScreenSize().ScreenWidth(context),
            //         ScreenSize().ScreenHeight(context) / 3),
            //     labelX: ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5'],
            //     labelY: ['20%', '40%', '60%', '80%', '100%'],
            //     // showDescription: true,
            //     graphColor: CustomColors().blue,
            //     graphOpacity: 0.2,
            //     verticalFeatureDirection: true,
            //     descriptionHeight: 130,
            //   ),
            // // the first char ends here

            //   // the middle chart starts here
            //   Container(
            //     //color: Colors.blueGrey[900],
            //     width: ScreenSize().ScreenWidth(context),
            //     height: ScreenSize().ScreenHeight(context) / 3,
            //     child: LineChart(
            //       LineChartData(
            //           borderData: FlBorderData(
            //               show: true,
            //               border: Border.all(color: Colors.white, width: 2)),
            //           maxX: 8,
            //           maxY: 8,
            //           minX: 0,
            //           minY: 0,
            //           lineBarsData: [
            //             LineChartBarData(
            //                 spots: [
            //                   FlSpot(0, 0),
            //                   FlSpot(5, 5),
            //                   FlSpot(7, 6),
            //                   FlSpot(8, 4)
            //                 ],
            //                 isCurved: true,
            //                 gradient: linegrad,
            //                 barWidth: 5,
            //                 belowBarData: BarAreaData(
            //                     show: true,
            //                     // color: gradientColors
            //                     //     .map((e) => e.withOpacity(0.3))
            //                     //     .toList(),
            //                     gradient: grad))
            //           ]),
            //     ),
            //   ),

            //   // middle chart ends here

            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // ignore: prefer_const_constructors
              child: Text(
                'Store View',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold),
              ),
            ),

            LineGraphWiget(points: storeview),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Orders',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold),
              ),
            ),

            LineGraphWiget(points: orders)
          ],
        ),
      ),
    );
  }
}
