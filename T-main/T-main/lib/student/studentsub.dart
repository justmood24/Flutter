import 'package:app/student/attendancepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class studentsub extends StatefulWidget {
  const studentsub({super.key});

  @override
  _StudentsubState createState() => _StudentsubState();
}

class _StudentsubState extends State<studentsub> {
  List<dynamic> courses = [];

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? studentId = prefs.getInt('student_id') ?? 1;

    // Replace 'your_local_ip' with the actual IP address of your development machine
    final response = await http.get(Uri.parse('http://localhost:8000/get-courses?student_id=$studentId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      setState(() {
        courses = data;
      });
    } else {
      throw Exception('Failed to load courses');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Courses'),
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: courses.isEmpty
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: courses.map((course) => buildCourseContainer(context, course)).toList(),
        ),
      ),
    );
  }

  Widget buildCourseContainer(BuildContext context, dynamic course) {
    return Column(
      children: [
        Container(
          height: 80,
          width: 150,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(12),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return attendance(courseId: course['course_id']);
                  },
                ),
              );
            },
            child: Center(
              child: Text(
                course['course_code'],
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}