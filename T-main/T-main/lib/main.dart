import 'package:app/firstpage.dart';
import 'package:app/screens/homepage.dart';
import 'package:app/screens/profile.dart';
import 'package:app/screens/scaaan.dart';
import 'package:app/secondpage.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const chatup());
}

class chatup extends StatelessWidget {
  const chatup({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home()
    );
  }
}
