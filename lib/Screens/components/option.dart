import 'package:flutter/material.dart';

import '../../Shared/customColors.dart';

class Option extends StatelessWidget {
  const Option(
      {Key? key, required this.width, required this.title, required this.icon})
      : super(key: key);

  final double width;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
      child: Container(
        width: width,
        height: width * 0.165,
        decoration: BoxDecoration(
            border: Border.all(
              color: CustomColors().blue,
            ),
            borderRadius: BorderRadius.all(Radius.circular(28))),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 30,
                    color: CustomColors().blue,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(title,
                      style: TextStyle(
                          fontSize: 24.0,
                          color: CustomColors().black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500))
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 25,
                color: CustomColors().blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
