// import 'package:app/screens/qrcode2.dart';
// import 'package:app/screens/scaaan.dart';
// import 'package:app/screens/scan.dart';
// import 'package:flutter/material.dart';

// //import 'screens/scanqr.dart';

// void main() {
//   runApp( MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Scanner App',
//       theme: ThemeData(
//         primarySwatch: Colors.deepPurple,
//       ),
//       home: MyHomePage(title: 'Scanner App'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Qrcode()));
//                   print('creating qr code');
//                 },
//                 child: Text('create QR code')),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>ScanScreen()));
//                   print('Read qr code');
//                 },
//                 child: Text('Read QR code')),
//           ],
//         ),
//       ),
//     );
//   }
// }