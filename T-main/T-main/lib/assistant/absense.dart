import 'package:flutter/material.dart';

class AttendancePage extends StatefulWidget {
 final List<List<String>> data;

 const AttendancePage({super.key, required this.data});

 @override
 _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
 @override
 Widget build(BuildContext context) {
  return Scaffold(
   appBar: AppBar(
    title: Text('Attendance List'),
    leading: IconButton(
     icon: Icon(Icons.arrow_back),
     onPressed: () {
      Navigator.pop(context);
     },
    ),
   ),
   body: SingleChildScrollView(
    child: Table(
     border: TableBorder.all(),
     columnWidths: {
      0: FixedColumnWidth(100),
      1: FlexColumnWidth(),
      2: FlexColumnWidth(),
     },
     children: widget.data.map((row) {
      return TableRow(
       children: row.map((cell) {
        return TableCell(
         child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(cell),
         ),
        );
       }).toList(),
      );
     }).toList(),
    ),
   ),
  );
 }
}
