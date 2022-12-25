import 'package:flutter/material.dart';

import '../../../../../../Shared/customColors.dart';

class RangeButton extends StatefulWidget {
  bool fixed;
  RangeButton({super.key, required this.fixed});

  @override
  State<RangeButton> createState() => _RangeButtonState();
}

class _RangeButtonState extends State<RangeButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
            width: 1,
            color: widget.fixed ? CustomColors().blue : CustomColors().white),
        color: widget.fixed ? CustomColors().white : CustomColors().blue,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Center(
          child: Text(
        "Range",
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: widget.fixed ? CustomColors().blue : CustomColors().white),
      )),
    );
  }
}
