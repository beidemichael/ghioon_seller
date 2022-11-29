import 'package:flutter/material.dart';
import 'package:ghioon_seller/Shared/customColors.dart';

Widget alertLists({
  Key? key,
  String? title,
  IconData? icon,
  VoidCallback? onTap,
}) {
  return InkWell(
    splashColor: CustomColors().blue,
    onTap: onTap,
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 20, 10),
          child: Icon(icon, color: CustomColors().blue),
        ),
        Text(
          title!,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        )
      ],
    ),
  );
}
