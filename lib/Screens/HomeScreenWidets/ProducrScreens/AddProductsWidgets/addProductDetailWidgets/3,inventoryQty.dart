import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../Models/RangeProvider.dart';
import '../../../../../Shared/customColors.dart';

class InventoryQty extends StatefulWidget {
  var inventory;
  InventoryQty({super.key, required this.inventory});

  @override
  State<InventoryQty> createState() => _InventoryQtyState();
}

class _InventoryQtyState extends State<InventoryQty> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      const Text(
        "Inventory (Qty)",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
      ),
      const SizedBox(
        width: 15,
      ),
      Row(
        children: [
          GestureDetector(
            onTap: () {
              Provider.of<RangeData>(context, listen: false).minusInventory();
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: CustomColors().grey),
                color: CustomColors().grey,
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
              child: const Center(
                  child: Text(
                "-",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )),
            ),
          ),
          Container(
            width: 80,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: CustomColors().grey),
              color: CustomColors().white,
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
                child: TextField(
                    keyboardType: TextInputType.number,
                    controller: widget.inventory,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold))),
          ),
          GestureDetector(
            onTap: () {
              Provider.of<RangeData>(context, listen: false).addInventory();
            },
            child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: CustomColors().grey),
                  color: CustomColors().grey,
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
                child: const Center(
                  child: Text("+",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                )),
          )
        ],
      ),
    ]);
  }
}
