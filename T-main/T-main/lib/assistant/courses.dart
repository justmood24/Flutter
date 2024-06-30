import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app/assistant/sections.dart';

class subjects extends StatefulWidget {
  const subjects({super.key});

  @override
  _SubjectsState createState() => _SubjectsState();
}

class _SubjectsState extends State<subjects> {
  List<dynamic> courses = [];

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? taId = prefs.getInt('ta_id'); // Assuming ta_id is stored as an integer

    if (taId != null) {
      final response = await http.get(Uri.parse('http://localhost:8000/teaching-assistants/courses?ta_id=$taId'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          setState(() {
            courses = data['data'];
          });
        }
      } else {
        // Handle error
        print('Failed to load courses');
      }
    } else {
      // Handle the case where ta_id is not set
      print('TA ID not found in SharedPreferences');
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: courses.map((course) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return sections(courseId: course['course_id']); // Pass the course ID
                    },
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 100,
                width: 200,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '${course['course_code']} (ID: ${course['course_id']})',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
