import 'package:app/assistant/weeks.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app/assistant/absense.dart'; // Import the WeeksPage widget

class sections extends StatefulWidget {
  final int courseId;

  const sections({super.key, required this.courseId});

  @override
  _SectionsState createState() => _SectionsState();
}

class _SectionsState extends State<sections> {
  List<dynamic> sections = [];

  @override
  void initState() {
    super.initState();
    _loadSections();
  }

  Future<void> _loadSections() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? taId = prefs.getInt('ta_id'); // Assuming ta_id is stored as an integer

    if (taId != null) {
      final response = await http.get(Uri.parse('http://localhost:8000/teaching-assistants/sections?ta_id=$taId'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          final courseSections = data['data'].values
              .expand((sections) => sections as Iterable<dynamic>)
              .toList();
          setState(() {
            sections = courseSections.where((section) => section['course_id'] == widget.courseId).toList();
          });
        }
      } else {
        // Handle error
        print('Failed to load sections');
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
        title: Text('Available Sections'),
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: sections.isEmpty
            ? Text('No sections available for this course')
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: sections.map((section) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WeeksPage(
                        sectionId: section['section_id'],
                        courseId: widget.courseId, // Pass the courseId here
                      );
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
                    'Section ID: ${section['section_id']}',
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
