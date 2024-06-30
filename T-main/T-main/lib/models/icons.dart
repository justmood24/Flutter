import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/screens/profile.dart';
import 'package:app/student/schedule.dart';
import 'package:app/student/qrcode2.dart';
import 'package:app/student/studentsub.dart';
import 'package:app/student/yourprofile.dart';

class icons extends StatefulWidget {
  const icons({super.key});

  @override
  _IconsPageState createState() => _IconsPageState();
}

class _IconsPageState extends State<icons> {
  String? name;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    fetchStudentData();
  }

  Future<void> fetchStudentData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? studentId = prefs.getInt('student_id');

    final response = await http.get(Uri.parse('http://localhost:8000/student?student_id=$studentId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      setState(() {
        name = data['name'];
        imageUrl = data['image'];
      });
    } else {
      throw Exception('Failed to load student data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation Menu'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          Center(
            child: CircleAvatar(
              radius: 40,
              backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : AssetImage('assets/profile.jpg') as ImageProvider,
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              name ?? "Your Profile Name",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          SizedBox(height: 20),
          Divider(color: Colors.blue, height: 1),
          buildListTile(context, Icons.home, 'Home', yourprofile()),
          SizedBox(height: 10),
          buildListTile(context, Icons.square, 'Schedule', Schedule()),
          SizedBox(height: 10),
          buildListTile(context, Icons.circle, 'Attendance', studentsub()),
          SizedBox(height: 10),
          buildListTile(context, Icons.settings, 'Settings', null),
        ],
      ),
    );
  }

  ListTile buildListTile(BuildContext context, IconData icon, String title, Widget? page) {
    return ListTile(
      onTap: page != null
          ? () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      }
          : null,
      leading: Icon(
        icon,
        size: 30,
        color: Colors.blue,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}
