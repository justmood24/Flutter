import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'AttendanceDetails.dart';
// Import the new page here

class attendance extends StatefulWidget {
  final int courseId;

  const attendance({super.key, required this.courseId});

  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<attendance> {
  bool isLoading = false;

  Future<void> fetchSectionAndNavigate() async {
    setState(() {
      isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? studentId = prefs.getInt('student_id') ?? 1;

    final response = await http.get(
      Uri.parse('http://localhost:8000/get-section?course_id=${widget.courseId}&student_id=$studentId'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        int sectionId = data['section_id'];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return AttendanceDetailsPage( // Navigate to the new page
                sectionId: sectionId,
                courseId: widget.courseId,
              );
            },
          ),
        );
      } else {
        // Handle failure status
        showErrorDialog(context, 'Failed to fetch section. Please try again.');
      }
    } else {
      // Handle HTTP error
      showErrorDialog(context, 'Failed to fetch section. Please try again.');
    }

    setState(() {
      isLoading = false;
    });
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
        title: Text('Available Sections'),
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : ElevatedButton(
          onPressed: fetchSectionAndNavigate,
          child: Text(
            ' Section ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
        ),
      ),
    );
  }
}
