import 'package:flutter/material.dart';
import 'package:ghioon_seller/Providers/language_provider.dart';
import 'package:ghioon_seller/Shared/language.dart';
import 'package:provider/provider.dart';

import '../CustomBarCharLogic/ArrageByDateLogic.dart';

class BottomText extends StatelessWidget {
  String item;
  List<List> listOfDateLists;
  int index;
  BottomText(
      {super.key,
      required this.item,
      required this.listOfDateLists,
      required this.index});

  @override
  Widget build(BuildContext context) {
    var languageprov = Provider.of<LanguageProvider>(context);
    return Container(
      height: 40,
      width: 60,
      child: Center(
        child: item == Language().day[languageprov.LanguageIndex]
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextWidget(item == Language().day[languageprov.LanguageIndex]
                      ? ArrageByDateLogic()
                          .monTuesWedConversion(listOfDateLists[index].first)
                          .toString()
                      : ''),
                  TextWidget(ArrageByDateLogic()
                      .dateConversion(listOfDateLists[index].first)
                      .toString()),
                ],
              )
            : TextWidget(item == Language().week[languageprov.LanguageIndex]
                ? ArrageByDateLogic()
                    .dateConversion(listOfDateLists[index].first)
                    .toString()
                : item == Language().month[languageprov.LanguageIndex]
                    ? ArrageByDateLogic()
                        .monthConversion(listOfDateLists[index].first)
                        .toString()
                    : ArrageByDateLogic()
                        .yearConversion(listOfDateLists[index].first)
                        .toString()),
      ),
    );
  }

  Widget TextWidget(text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }
}
