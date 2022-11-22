import 'package:flutter/material.dart';
import 'package:ghioon_seller/Shared/customColors.dart';

class ShortProductGrid extends StatelessWidget {
  const ShortProductGrid({
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
      height: width / 2,
      decoration: BoxDecoration(
        border: Border.all(
            width: 1, color: const Color.fromARGB(255, 224, 224, 224)),
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
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: CustomColors().white,
                size: 50,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: width / 17,
                      color: CustomColors().white,
                      fontWeight: FontWeight.w600))
            ]),
      ),
    );
  }
}
