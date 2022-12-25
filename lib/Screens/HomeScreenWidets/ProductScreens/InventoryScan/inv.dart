// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class Scan extends StatefulWidget {
//   const Scan({super.key});

//   @override
//   State<Scan> createState() => _ScanState();
// }

// class _ScanState extends State<Scan> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       child: Flex(
//           direction: Axis.vertical,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Image(
//               image: AssetImage("assets/logo.png"),
//               height: 150,
//             ),
//             const SizedBox(
//               height: 50,
//             ),
//             Text('Scan result : $_scanBarcode\n',
//                 style: const TextStyle(
//                     fontSize: 20, fontWeight: FontWeight.bold)),
//             SizedBox(
//               height: 45,
//               child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.cyan,
//                   ),
//                   onPressed: () => barcodeScan(),
//                   child: const Text('Barcode Scan',
//                       style: TextStyle(
//                           fontSize: 17, fontWeight: FontWeight.bold))),
//             ),
//           ]));
//   }
// }