// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Screens/components/emptyScreen.dart';
import 'package:ghioon_seller/Shared/constants.dart';
import 'package:ghioon_seller/Shared/customColors.dart';
import 'package:provider/provider.dart';

class StoreProfile extends StatefulWidget {
  const StoreProfile({super.key});

  @override
  State<StoreProfile> createState() => _StoreProfileState();
}

class _StoreProfileState extends State<StoreProfile> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserInformation>>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    const upperTab =
        TabBar(indicatorColor: Colors.white, indicatorWeight: 3, tabs: <Tab>[
      Tab(
        child: Text('Product',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w500)),
      ),
      Tab(
        child: Text('Collection',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w500)),
      ),
    ]);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(300.0),
          child: AppBar(
              centerTitle: true,
              toolbarHeight: 250,
              title: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Column(
                            children: [
                              Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: CustomColors().darkBlue,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Icon(
                                    FontAwesomeIcons.userLarge,
                                    size: 80.0,
                                    color: Colors.white,
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                  userInfo[0].businessName, //'Endale Abegazee',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      color: CustomColors().white,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        height: 10,
                        thickness: 1,
                        color: CustomColors().white,
                      ),
                      Container(
                        height: 50,
                        width: ScreenSize().ScreenWidth(context),
                        color: CustomColors().blue,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.visibility,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '25',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  ],
                                )),
                              ),
                              Expanded(
                                child: Container(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '4.5',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  ],
                                )),
                              )
                            ]),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => AccountEdit(
                    //             appState: appState,
                    //             user: userInfo[0],
                    //           )),
                    // );
                  },
                  child: Center(
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        // border: Border.all(
                        //     width: 1, color: Color.fromARGB(255, 255, 255, 255)),
                        color: CustomColors().white,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.penToSquare,
                          size: 25.0,
                          color: CustomColors().blue,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
              excludeHeaderSemantics: true,
              backgroundColor: CustomColors().blue,
              elevation: 3,
              bottom: upperTab,
              iconTheme: const IconThemeData(color: Colors.white)),
        ),
        body: TabBarView(
          children: [
            // EmptyScreen(context, 'Products.'),
            // EmptyScreen(context, 'Collections')
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 8.0,
                  children: List.generate(choices.length, (index) {
                    return Center(
                      child: SelectCard(choice: choices[index]),
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }
}

//List of center grid
class Choice {
  const Choice({required this.title, required this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Home', icon: Icons.home),
  const Choice(title: 'Contact', icon: Icons.contacts),
  const Choice(title: 'Map', icon: Icons.map),
  const Choice(title: 'Phone', icon: Icons.phone),
  const Choice(title: 'Camera', icon: Icons.camera_alt),
  const Choice(title: 'Setting', icon: Icons.settings),
  const Choice(title: 'Album', icon: Icons.photo_album),
  const Choice(title: 'WiFi', icon: Icons.wifi),
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    // final TextStyle textStyle = Theme.of(context).textTheme.;
    return Card(
        color: Colors.orange,
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Icon(choice.icon, size: 50.0, color: Colors.red)),
                Text(choice.title, style: TextStyle(fontSize: 15)),
              ]),
        ));
  }
}
