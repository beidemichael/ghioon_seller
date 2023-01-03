import 'package:flutter/material.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Screens/components/textFormField.dart';
import 'package:provider/provider.dart';

import '../../../../../../Providers/EditRangeProvider.dart';
import '../../../../../../Shared/customColors.dart';
import '5,editinventoryQty.dart';

class EditFixedInputField extends StatefulWidget {
  var product;
  EditRangeData appState;
  EditFixedInputField(
      {super.key, required this.product, required this.appState});

  @override
  State<EditFixedInputField> createState() => _EditFixedInputFieldState();
}

class _EditFixedInputFieldState extends State<EditFixedInputField> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.appState.fixedPrice.text = widget.product.rangeTo[0].toString();
    widget.appState.oldPrice.text = widget.product.rangeFrom[0].toString();
    widget.appState.cost.text = widget.product.price[0].toString();
   
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<EditRangeData>(context);
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
                  child: TextFormFieldProductInitialValue(
                      widget.appState.fixedPrice, TextInputType.number)),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                  child: TextFormFieldProductInitialValue(
                      widget.appState.oldPrice, TextInputType.number))
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
                      TextFormFieldWithOutLabel('Cost per Item',
                          widget.appState.cost, TextInputType.number),
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
                      padding: const EdgeInsets.only(bottom: 22.0),
                      child: Text(
                          widget.appState.fixedPrice.text.isNotEmpty ||
                                  widget.appState.cost.text.isNotEmpty
                              ? (double.parse(widget.appState.fixedPrice.text) -
                                      double.parse(widget.appState.cost.text))
                                  .toString()
                              : '0',
                          //'abadb',
                          style: const TextStyle(
                              fontSize: 30.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ))
              ],
            ),
          ),
          // Visibility(
          //   visible: !appState.fixedFilled,
          //   child: const Center(
          //     child: Text(
          //       "Please fill all inputs",
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //           fontSize: 18,
          //           fontWeight: FontWeight.w300,
          //           color: Colors.red),
          //     ),
          //   ),
          // ),
          EditInventoryQty(inventory: widget.product.quantity,appState: appState),
        ],
      ),
    );
  }
}
