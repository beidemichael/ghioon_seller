import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../Providers/RangeProvider.dart';
import '../../../../../Shared/customColors.dart';
import '../../../../components/textFormField.dart';
import '3,inventoryQty.dart';

class FixedInputField extends StatefulWidget {
  const FixedInputField({super.key});

  @override
  State<FixedInputField> createState() => _FixedInputFieldState();
}

class _FixedInputFieldState extends State<FixedInputField> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<RangeData>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Fixed Price",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: CustomColors().blue),
          ),
          Row(
            children: [
              Expanded(
                  child: TextFormFieldWithOutLabel(
                      'New Price', appState.fixedPrice, TextInputType.number)),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                  child: TextFormFieldWithOutLabel(
                      'Old Price', appState.oldPrice, TextInputType.number))
            ],
          ),
          Container(
            height: 105,
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Profit",
                        style: TextStyle(
                            fontSize: 22.0,
                            color: CustomColors().blue,
                            fontWeight: FontWeight.w500),
                      ),
                      TextFormFieldWithOutLabel(
                          'Cost per Item', appState.cost, TextInputType.number),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Profit",
                          style: TextStyle(
                              fontSize: 22.0,
                              color: CustomColors().blue,
                              fontWeight: FontWeight.w500),
                        ),
                        // SizedBox(
                        //   height: 25,
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(bottom:22.0),
                          child: Text(
                              appState.fixedPrice.text.isNotEmpty ||
                                      appState.cost.text.isNotEmpty
                                  ? (double.parse(appState.fixedPrice.text) -
                                          double.parse(appState.cost.text))
                                      .toString()
                                  : '0',
                              //'abadb',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.w500)),
                        ),
                       
                      ],
                    ))
              ],
            ),
          ),
          Visibility(
            visible: !appState.fixedFilled,
            child: const Center(
              child: Text(
                "Please fill all inputs",
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
