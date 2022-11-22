import 'package:flutter/material.dart';
import 'package:ghioon_seller/Shared/customColors.dart';

class LongProductGrid extends StatelessWidget {
  const LongProductGrid({
    Key? key,
    required this.width,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final double width;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width / 2 + width / 10,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: CustomColors().blue),
        color: CustomColors().white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: CustomColors().blue,
                size: 50,
              ),
              SizedBox(
                height: 15,
              ),
              Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: width / 14,
                      color: CustomColors().blue,
                      fontWeight: FontWeight.w600))
            ]),
      ),
    );
  }
}
