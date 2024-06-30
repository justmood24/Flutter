import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class Qrcode extends StatelessWidget {
  final String qrData;

  const Qrcode({super.key, required this.qrData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR code Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BarcodeWidget(
            data: qrData,
            barcode: Barcode.qrCode(),
            color: Colors.deepPurple,
            height: 250,
            width: 250,
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width,
          )
        ],
      ),
    );
  }
}
