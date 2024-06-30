import 'package:app/student/qrcode2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barcode_widget/barcode_widget.dart';

class yourprofile extends StatefulWidget {
  const yourprofile({super.key});

  @override
  _YourProfileState createState() => _YourProfileState();
}

class _YourProfileState extends State<yourprofile> {
  String? name;
  String? email;
  String? faculty;
  String? level;
  String? sectionGroupNumber;
  String? imageUrl;
  int? studentId;

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      studentId = prefs.getInt('student_id');

      if (studentId == null) {
        _showErrorDialog('Student ID not found in SharedPreferences');
        return;
      }

      final response = await http.get(
        Uri.parse('http://localhost:8000/student?student_id=$studentId'),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['success'] == true) {
          setState(() {
            name = responseBody['data']['name'];
            email = responseBody['data']['email'];
            faculty = responseBody['data']['faculty'];
            level = responseBody['data']['level'];
            sectionGroupNumber = responseBody['data']['section_group_number'];
            imageUrl = responseBody['data']['image'];
          });
        } else {
          _showErrorDialog(responseBody['message'] ?? 'Unknown error');
        }
      } else {
        _showErrorDialog('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to connect to the server: $e');
      _showErrorDialog('Failed to connect to the server: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: imageUrl != null
                        ? Image.network(imageUrl!)
                        : Image.asset(''),//lib/assets/arwa.jpg
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  name ?? 'Loading...',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                _buildProfileField('Name:', name),
                SizedBox(
                  height: 20,
                ),
                _buildProfileField('Faculty:', faculty),
                SizedBox(
                  height: 20,
                ),
                _buildProfileField('Level:', level),
                SizedBox(
                  height: 20,
                ),
                _buildProfileField('Email:', email),
                SizedBox(
                  height: 20,
                ),
                _buildProfileField('Sec Group:', sectionGroupNumber),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (name != null && email != null && studentId != null) {
                      final qrData =
                          'ID: $studentId, Name: $name, Email: $email, Faculty: $faculty, Level: $level, Group: $sectionGroupNumber';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Qrcode(qrData: qrData),
                        ),
                      );
                    }
                  },
                  child: Text('QR Code'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: value != null ? '$label $value' : 'Loading...',
            ),
            readOnly: true,
          ),
        ),
      ),
    );
  }
}
