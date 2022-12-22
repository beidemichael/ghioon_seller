import 'package:flutter/material.dart';
import 'package:ghioon_seller/Shared/customColors.dart';

import '../../../../../Models/models.dart';

class TitleAndDescription extends StatefulWidget {
  Product product;
  TitleAndDescription({super.key, required this.product});

  @override
  State<TitleAndDescription> createState() => _TitleAndDescriptionState();
}

class _TitleAndDescriptionState extends State<TitleAndDescription> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.product.name,
                style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'Inter',
                    color: CustomColors().blue,
                    fontWeight: FontWeight.w700)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.product.fixed == true
                          ? Colors.purple.withOpacity(0.1)
                          : Colors.blue.withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2.5),
                      child: Text(
                          widget.product.fixed == true
                              ? 'Fixed Price'
                              : 'Range',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: widget.product.fixed == true
                                  ? Colors.purple.withOpacity(0.7)
                                  : Colors.blue.withOpacity(0.9),
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Inter',
                            color: CustomColors().grey,
                            fontWeight: FontWeight.w700)),
                    Text('ETB ' + widget.product.price[0].toString(),
                        style: TextStyle(
                            fontSize: 30.0,
                            fontFamily: 'Inter',
                            color: CustomColors().black,
                            fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.product.inStock == true
                        ? Colors.green.withOpacity(0.2)
                        : Colors.red.withOpacity(0.2),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                      bottomLeft: Radius.circular(40.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2.5),
                    child: Text(
                        widget.product.inStock == true
                            ? 'In Stock'
                            : 'Out of Stock',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: widget.product.inStock == true
                                ? Colors.green.withOpacity(0.7)
                                : Colors.red.withOpacity(0.9),
                            fontWeight: FontWeight.w400)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                      bottomLeft: Radius.circular(40.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2.5),
                    child: Text(
                        widget.product.quantity.toString() + ' items left',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.orange.withOpacity(0.9),
                            fontWeight: FontWeight.w400)),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 15, 5, 5),
            child: Text('Product Description',
                style: TextStyle(
                    fontSize: 22.0,
                    fontFamily: 'Inter',
                    color: CustomColors().black,
                    fontWeight: FontWeight.w600)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.product.description,
                style: const TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Poppins',
                    color: Color.fromARGB(255, 109, 109, 109),
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
