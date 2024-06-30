import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Lecture and Section Schedule',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Image.asset('lib/assets/Schedule.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//////////////////////////
// import 'package:flutter/material.dart';
// import 'package:excel/excel.dart';
// import 'package:flutter/services.dart' show ByteData, rootBundle;

// class Schedule extends StatefulWidget {
//   @override
//   _ScheduleState createState() => _ScheduleState();
// }

// class _ScheduleState extends State<Schedule> {
//   List<List<String>> scheduleData = [];

//   @override
//   void initState() {
//     super.initState();
//     loadExcelData();
//   }

//   Future<void> loadExcelData() async {
//     ByteData data = await rootBundle.load('lib/assets/Schedule.png');
//     var bytes = data.buffer.asUint8List();
//     var excel = Excel.decodeBytes(bytes);

//     List<List<String>> tempData = [];
//     for (var table in excel.tables.keys) {
//       var sheet = excel.tables[table];
//       if (sheet != null) {
//         for (var row in sheet.rows) {
//           List<String> rowData = row.map((cell) => cell?.value.toString() ?? '').toList();
//           tempData.add(rowData);
//         }
//       }
//     }

//     setState(() {
//       scheduleData = tempData;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Schedule Page'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               margin: EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   Text(
//                     'Lecture and Section Schedule',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 10),
//                   scheduleData.isEmpty
//                       ? CircularProgressIndicator()
//                       : DataTable(
//                           columns: scheduleData[0]
//                               .map((header) => DataColumn(label: Text(header)))
//                               .toList(),
//                           rows: scheduleData
//                               .sublist(1)
//                               .map((row) => DataRow(
//                                     cells: row.map((cell) => DataCell(Text(cell))).toList(),
//                                   ))
//                               .toList(),
//                         ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
