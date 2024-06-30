// import 'package:app/screens/scan.dart';
// import 'package:barcode_widget/barcode_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// class QRCodeScreen extends StatelessWidget {
//   // final Reservation reservation;
//   // final int selectedSlotIndex; // Add selectedSlotIndex parameter

//   const QRCodeScreen({
//     Key? key,
//     // required this.reservation,
//     // required this.selectedSlotIndex, // Initialize selectedSlotIndex
//   }) : super(key: key);

//   Future<void> _scanQRCode(BuildContext context) async {
//     String scannedData = await FlutterBarcodeScanner.scanBarcode(
//       '#ff6666', // Scanner overlay color
//       'Cancel', // Cancel button text
//       true, // Use front camera
//       ScanMode.QR, // Scan mode (QR, BARCODE, etc.)
//     );

//     if (scannedData.isNotEmpty) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Scanned Data'),
//           content: Text(scannedData),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }  

//   @override
//   Widget build(BuildContext context) {
//     // String qrData =
//     //     "${reservation.doctorName}, ${reservation.specialization}, رقم الدور: ${selectedSlotIndex + 1}, الادوار المتبقية: ${reservation.remainingTurns}";

//     var qrData;
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.only(right: 10, top: 50),
//         child: Align(
//           alignment: Alignment.topCenter,
//           child: Column(
//             children: [
//               SizedBox(height: 20),
//               Text(
//                 'تم الحجز بنجاح',
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF6361B4),
//                 ),
//               ),
//               SizedBox(height: 10),
//               Stack(
//                 alignment: Alignment.topRight,
//                 children: [
//                   Container(
//                     width: 350,
//                     height: 200,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(.5),
//                           spreadRadius: 0,
//                           blurRadius: 10,
//                           offset: Offset(0, 20),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: CircleAvatar(
//                       radius: 35,
//                       backgroundImage: AssetImage('assets/doc.jpeg'),
//                     ),
//                   ),
//                   Positioned(
//                     top: 20,
//                     right: 100,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
                       
//                       ],
//                     ),
//                   ),
                 
                        
//               ),
//               SizedBox(height: 40),
//               Container(
//                 width: 300,
//                 height: 300,
//                 child: BarcodeWidget(
//                   barcode: Barcode.qrCode(),
//                   data: qrData, // Encode reservation data into QR code
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => _scanQRCode(context),
//                 child: Text('Scan QR Code'),
//               ),
//               SizedBox(height: 10),
            
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }