import 'package:flutter/material.dart';
import 'package:ghioon_seller/Shared/customColors.dart';

class BlueDashboardGrid extends StatelessWidget {
  const BlueDashboardGrid({
    Key? key,
    required this.width,
    required this.title,
    required this.icon,
    required this.subTitle,
  }) : super(key: key);

  final double width;
  final String title;
  final IconData icon;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width / 2,
      decoration: BoxDecoration(
        border: Border.all(
            width: 1, color: CustomColors().white),
        color: CustomColors().blue,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: width / 10,
                      color: CustomColors().white,
                      fontWeight: FontWeight.w600)),
              const SizedBox(
                height: 15,
              ),
              Icon(
                icon,
                color: CustomColors().white,
                size: 50,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(subTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: width / 20,
                      color: CustomColors().white,
                      fontWeight: FontWeight.w600))
            ]),
      ),
    );
  }
}
