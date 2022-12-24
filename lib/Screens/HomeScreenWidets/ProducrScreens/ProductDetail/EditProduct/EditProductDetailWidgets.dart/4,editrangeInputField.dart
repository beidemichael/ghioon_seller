import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Models/models.dart';
import 'package:ghioon_seller/Screens/components/textFormField.dart';
import 'package:provider/provider.dart';

import '../../../../../../Models/addProductmodels.dart';
import '../../../../../../Providers/EditRangeProvider.dart';
import '../../../../../../Shared/customColors.dart';
import '5,editinventoryQty.dart';

class EditRangeInputField extends StatefulWidget {
  Product product;
  EditRangeInputField({super.key, required this.product});

  @override
  State<EditRangeInputField> createState() => _EditRangeInputFieldState();
}

class _EditRangeInputFieldState extends State<EditRangeInputField> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<EditRangeData>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Row(children: [
              Text(
                "Range Price",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: CustomColors().blue),
              ),
              const SizedBox(
                width: 10,
              ),
            ]),
          ),
          ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.product.price.length,
              itemBuilder: (context, index) {
                return RangeCard(
                  fromString: widget.product.rangeFrom[index].toString(),
                  tOString: widget.product.rangeTo[index].toString(),
                  priceString: widget.product.price[index].toString(),
                  index: index,
                  appState: appState,
                );
              }),
          // Visibility(
          //   visible: !appState.rangefilled,
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
          EditInventoryQty(inventory: widget.product.quantity,appState: appState,),
        ],
      ),
    );
  }
}

class RangeCard extends StatefulWidget {
  String fromString;
  String tOString;
  String priceString;
  int index;
  var appState;
  RangeCard({
    super.key,
    required this.fromString,
    required this.priceString,
    required this.tOString,
    required this.index,
    required this.appState,
  });

  @override
  State<RangeCard> createState() => _RangeCardState();
}

class _RangeCardState extends State<RangeCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.appState.Ranges.add(
      Range(
        fromcontroller: TextEditingController(text: widget.fromString),
        tocontroller: TextEditingController(text: widget.tOString),
        pricecontroller: TextEditingController(text: widget.priceString),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<EditRangeData>(context);
    return Row(
      children: [
        Expanded(
            child: TextFormFieldProductInitialValue(
                appState.Ranges[widget.index].fromcontroller!,
                TextInputType.number)),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "-",
            style: TextStyle(fontSize: 30),
          ),
        ),
        Expanded(
            child: TextFormFieldProductInitialValue(
                appState.Ranges[widget.index].tocontroller!,
                TextInputType.number)),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "=",
            style: TextStyle(fontSize: 30),
          ),
        ),
        Expanded(
            child: TextFormFieldProductInitialValue(
                //  widget.product.price[index],
                appState.Ranges[widget.index].pricecontroller!,
                TextInputType.number))
      ],
    );
  }
}
