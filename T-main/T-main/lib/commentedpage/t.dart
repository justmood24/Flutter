// import 'package:flutter/material.dart';

// void main() {
//   runApp(attendancePage());
// }

// class attendancePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Material
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//     0-----App(
//       debugShowCheckedModeBanner: false,
//       home: MyDynamicTable(),
//     );
//   }
// }

// class MyDynamicTable extends StatefulWidget {
//   @override
//   _MyDynamicTableState createState() => _MyDynamicTableState();
// }

// class _MyDynamicTableState extends State<MyDynamicTable> {
//   List<List<String>> _data = [
//     ['ID', 'Name', 'Section'],
//     ['1', 'arwa', '2'],
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       // appBar: AppBar(

//       //     // title: Text('Attendance Table'),

//       //           ),

//       body: SingleChildScrollView(
//         child: Table(
//           border: TableBorder.all(),
//           columnWidths: {
//             0: FixedColumnWidth(100),
//             1: FlexColumnWidth(),
//             2: FlexColumnWidth(),
//           },
//           children: _data.map((row) {
//             return TableRow(
//               children: row.map((cell) {
//                 return TableCell(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(cell),
//                   ),
//                 );
//               }).toList(),
//             );
//           }).toList(),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Add new row
//           setState(() {
//             _data.add(['New ID', 'New Name', 'New Section']);
//           });
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }