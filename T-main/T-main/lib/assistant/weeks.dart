import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'absense.dart';
 // Import the attendancePage

class WeeksPage extends StatelessWidget {
  final int sectionId;
  final int courseId; // Added courseId to the constructor

  const WeeksPage({super.key, required this.sectionId, required this.courseId});

  Future<List<List<String>>> _fetchAttendance(int weekNumber) async {
    final response = await http.get(
      Uri.parse('http://localhost:8000/attendance/students?section_id=$sectionId&course_id=$courseId&week_number=$weekNumber'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<List<String>> attendanceData = [
        ['ID', 'Name', 'Absence Status'],
      ];
      for (var student in data) {
        attendanceData.add([
          student['student_id'].toString(),
          student['name'],
          student['absence_status'],
        ]);
      }
      return attendanceData;
    } else {
      throw Exception('Failed to load attendance data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weeks for Section $sectionId'),
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(7, (index) {
            int weekNumber = index + 1;
            return GestureDetector(
              onTap: () async {
                try {
                  List<List<String>> attendanceData = await _fetchAttendance(weekNumber);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttendancePage(data: attendanceData),
                    ),
                  );
                } catch (e) {
                  print(e); // Handle error
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Week $weekNumber',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
