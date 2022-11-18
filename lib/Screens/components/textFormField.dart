import 'package:flutter/material.dart';
import 'package:ghioon_seller/Shared/customColors.dart';

Widget TextFormFieldWithIcon(String label, String hintText,
    TextEditingController control, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: TextFormField(
      keyboardType: TextInputType.text,
      controller: control,
      //initialValue: autoAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.blue),
          gapPadding: 10,
        ),
        suffixIcon: Icon(
          icon,
          size: 20.0,
          color: Colors.blue,
        ),
      ),
    ),
  );
}

Widget TextFormFieldWithOutIcon(
    String hintText, TextEditingController control, String header) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(header,
            style: const TextStyle(
                fontSize: 22.0,
                color: Color.fromARGB(255, 107, 107, 107),
                fontWeight: FontWeight.w500)),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          keyboardType: TextInputType.text,
          controller: control,
          //initialValue: autoAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hintText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Color.fromARGB(255, 214, 214, 214)),
              gapPadding: 10,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:  BorderSide(color: CustomColors().blue),
              gapPadding: 10,
            ),
          ),
        ),
      ],
    ),
  );
}
