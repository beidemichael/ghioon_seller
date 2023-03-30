import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../../Providers/RangeProvider.dart';
import '../../../../../../Models/addProductmodels.dart';
import '../../../../../../Providers/language_provider.dart';
import '../../../../../../Shared/customColors.dart';
import '../../../../../../Shared/language.dart';
import '../../../../../components/textFormField.dart';
import '3,inventoryQty.dart';

class RangeInputField extends StatefulWidget {
  const RangeInputField({super.key});

  @override
  State<RangeInputField> createState() => _RangeInputFieldState();
}

class _RangeInputFieldState extends State<RangeInputField> {
  @override
  Widget build(BuildContext context) {
    var languageprov = Provider.of<LanguageProvider>(context);
    final appState = Provider.of<RangeData>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Row(children: [
              Text(
                Language().range_price[languageprov.LanguageIndex],
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: CustomColors().blue),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  appState.addToList(Range(
                      fromcontroller: TextEditingController(),
                      tocontroller: TextEditingController(),
                      pricecontroller: TextEditingController()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: CustomColors().white,
                    border: Border.all(width: 1, color: CustomColors().blue),
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child:
                        Icon(FontAwesomeIcons.plus, color: CustomColors().blue),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  appState.removeLast();
                  print(appState.Ranges.length);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: CustomColors().blue),
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Icon(FontAwesomeIcons.minus,
                        color: CustomColors().blue),
                  ),
                ),
              )
            ]),
          ),
          ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: appState.Ranges.length,
              itemBuilder: (context, index) {
                // var currentStop = appState.Ranges[index];

                return Row(
                  children: [
                    Expanded(
                        child: TextFormFieldWithOutLabel(
                            Language().from[languageprov.LanguageIndex],
                            appState.Ranges[index].fromcontroller!,
                            TextInputType.number)),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "-",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Expanded(
                        child: TextFormFieldWithOutLabel(
                            Language().to[languageprov.LanguageIndex],
                            appState.Ranges[index].tocontroller!,
                            TextInputType.number)),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "=",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Expanded(
                        child: TextFormFieldWithOutLabel(
                            Language().price[languageprov.LanguageIndex],
                            appState.Ranges[index].pricecontroller!,
                            TextInputType.number))
                  ],
                );
              }),
          Visibility(
            visible: !appState.rangefilled,
            child: Center(
              child: Text(
                Language().please_fill_all_field[languageprov.LanguageIndex],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.red),
              ),
            ),
          ),
          InventoryQty(inventory: appState.inventory),
        ],
      ),
    );
  }
}
