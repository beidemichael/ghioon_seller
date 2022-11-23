import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Shared/customColors.dart';
import '../components/BlueDashboardGrid copy.dart';
import '../components/WhiteDashboardGrid.dart';
import '../components/ShortProductGrid.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: Container(),
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: WhiteDashboardGrid(
                    width: width,
                    title: "125K",
                    subTitle: 'Sales',
                    icon: FontAwesomeIcons.chartLine,
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: BlueDashboardGrid(
                    width: width,
                    title: "10K",
                    subTitle: 'Revenue',
                    icon: FontAwesomeIcons.coins,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: BlueDashboardGrid(
                    width: width,
                    title: "15",
                    subTitle: 'Products',
                    icon: FontAwesomeIcons.tag,
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: WhiteDashboardGrid(
                    width: width,
                    title: "150",
                    subTitle: 'Customers',
                    icon: FontAwesomeIcons.person,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
