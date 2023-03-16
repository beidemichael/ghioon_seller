import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:provider/provider.dart';
import '../../../../Models/models.dart';
import '../../../../Shared/constants.dart';
import '../../../../Shared/customColors.dart';
import '../../../../Shared/loading.dart';

class OrdersDetail extends StatefulWidget {
  Orders orders;
  OrdersDetail({super.key, required this.orders});

  @override
  State<OrdersDetail> createState() => _OrdersDetailState();
}

class _OrdersDetailState extends State<OrdersDetail> {
  double total = 0.0;
  int orderdItems = 0;
  calculator(Orders orders, UserInformation userInfo) {
    total = 0.0;
    orderdItems = 0;
    for (int i = 0; i < orders.foodName.length; i++) {
      if (widget.orders.sellerId[i] == userInfo.userUid) {
        total = total + orders.foodPrice[i];
        orderdItems++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserInformation>>(context);
    if (userInfo.isNotEmpty) {
      calculator(widget.orders, userInfo[0]);
    }
    return userInfo.isEmpty
        ? Loading()
        : Scaffold(
            backgroundColor: CustomColors().superLightBlue,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: AppBar(
                  centerTitle: true,
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text('Orders Detail',
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                  // excludeHeaderSemantics: true,
                  backgroundColor: CustomColors().blue,
                  // automaticallyImplyLeading: false,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  iconTheme: const IconThemeData(color: Colors.white)),
            ),
            body: ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    decoration: BoxDecoration(
                      color: CustomColors().white,
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors().blue,
                          spreadRadius: 0.5,
                          blurRadius: 3,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Picture(widget.orders.userPic, 150),
                          Marquee(
                            backDuration: Duration(milliseconds: 500),
                            directionMarguee: DirectionMarguee.oneDirection,
                            child: Text(widget.orders.userName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 25,
                                    color: CustomColors().black,
                                    fontWeight: FontWeight.w600)),
                          ),
                          Marquee(
                            backDuration: Duration(milliseconds: 500),
                            directionMarguee: DirectionMarguee.oneDirection,
                            child: Text(widget.orders.userPhone,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 25,
                                    color: CustomColors().grey,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 160,
                    decoration: BoxDecoration(
                      color: CustomColors().white,
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors().blue,
                          spreadRadius: 0.5,
                          blurRadius: 3,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text('Invoice Breakup',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 25,
                                  color: CustomColors().black,
                                  fontWeight: FontWeight.w300)),
                          Divider(),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 21,
                                        color: CustomColors().black,
                                        fontWeight: FontWeight.w300)),
                                Text(total.toStringAsFixed(0) + ' Birr',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 21,
                                        color: CustomColors().blue,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Orderd Items',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 21,
                                        color: CustomColors().black,
                                        fontWeight: FontWeight.w300)),
                                Text(orderdItems.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 21,
                                        color: CustomColors().blue,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    decoration: BoxDecoration(
                      color: CustomColors().white,
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors().blue,
                          spreadRadius: 0.5,
                          blurRadius: 3,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: widget.orders.foodName.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: ScreenSize().ScreenHeight(context),
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics(),
                                ),
                                itemCount: widget.orders.foodName.length,
                                itemBuilder: (context, index) {
                                  return widget.orders.sellerId[index] ==
                                          userInfo[0].userUid
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Card(index),
                                        )
                                      : Container();
                                },
                              ),
                            ),
                          )
                        : Container(
                            // color: Colors.red,
                            height: ScreenSize().ScreenHeight(context),
                            child: Center(
                              child: Text('No Products',
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      color: CustomColors().blue,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
  }

  Widget Card(index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 110,
      decoration: BoxDecoration(
        color: CustomColors().white,
        // border: Border.all(width: 1, color: Colors.black),
        boxShadow: [
          BoxShadow(
            color: CustomColors().lightBlue,
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            Picture(widget.orders.foodImage[index], 80),
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 194,
                  child: Marquee(
                    backDuration: Duration(milliseconds: 500),
                    directionMarguee: DirectionMarguee.oneDirection,
                    child: Text(widget.orders.foodName[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            color: CustomColors().darkBlue,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                Row(
                  children: [
                    Text('Price: ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            color: CustomColors().grey,
                            fontWeight: FontWeight.w400)),
                    Text(widget.orders.foodPrice[index].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            color: CustomColors().blue,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
                Row(
                  children: [
                    Text('Qty: ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            color: CustomColors().grey,
                            fontWeight: FontWeight.w400)),
                    Text(widget.orders.foodQuantity[index].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            color: CustomColors().blue,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget Picture(image, double size) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        // border:
        //     Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(100),
      ),
      child: image != ''
          ? ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: image,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: Container(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.grey[600]!),
                        value: downloadProgress.progress),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            )
          : const Icon(
              FontAwesomeIcons.box,
              size: 20.0,
              color: Colors.white,
            ),
    );
  }
}
