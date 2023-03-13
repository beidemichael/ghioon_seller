import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../Models/models.dart';
import '../../../../Shared/customColors.dart';

class OrdersCard extends StatefulWidget {
  Orders orders;
  OrdersCard({super.key, required this.orders});

  @override
  State<OrdersCard> createState() => _OrdersCardState();
}

class _OrdersCardState extends State<OrdersCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 110,
        decoration: BoxDecoration(
          color: CustomColors().white,
          // border: Border.all(width: 1, color: Colors.black),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              ProfilePic(widget.orders.userPic),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.orders.userName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 25,
                          color: CustomColors().darkBlue,
                          fontWeight: FontWeight.w600)),
                  Text(widget.orders.userPhone,
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
        ),
      ),
    );
  }

  Widget ProfilePic(image) {
    return Container(
      height: 80,
      width: 80,
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
                            AlwaysStoppedAnimation<Color>(Colors.grey[300]!),
                        value: downloadProgress.progress),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            )
          : const Icon(
              FontAwesomeIcons.userLarge,
              size: 40.0,
              color: Colors.white,
            ),
    );
  }
}
