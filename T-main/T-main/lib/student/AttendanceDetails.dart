import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceDetailsPage extends StatefulWidget {
  final int courseId;
  final int sectionId;

  const AttendanceDetailsPage({Key? key, required this.courseId, required this.sectionId}) : super(key: key);

  @override
  _AttendanceDetailsPageState createState() => _AttendanceDetailsPageState();
}

class _AttendanceDetailsPageState extends State<AttendanceDetailsPage> {
  bool isLoading = false;
  List<dynamic> attendanceData = [];

  @override
  void initState() {
    super.initState();
    fetchAttendanceData();
  }

  Future<void> fetchAttendanceData() async {
    setState(() {
      isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? studentId = prefs.getInt('student_id') ?? 1;

    final response = await http.get(
      Uri.parse('http://localhost:8000/students/attendance?course_id=${widget.courseId}&section_id=${widget.sectionId}&student_id=$studentId'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        attendanceData = data;
        isLoading = false;
      });
    } else {
      // Handle HTTP error
      showErrorDialog(context, 'Failed to fetch attendance data. Please try again.');
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Details'),
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : attendanceData.isEmpty
            ? Text('No attendance data available.')
            : DataTable(
          columns: [
            DataColumn(label: Text('Week')),
            DataColumn(label: Text('Status')),
          ],
          rows: attendanceData.map((attendance) {
            return DataRow(cells: [
              DataCell(Text('Week ${attendance['week_number']}')),
              DataCell(Text('${attendance['absence_status']}')),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
