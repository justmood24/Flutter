import 'package:app/models/icons.dart';
import 'package:app/models/infocard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
      body: Container(
        width: 288,
        height: double.infinity,
        color: Color(0xff17203A),
        child: Column(
          children: [
          
            infocard(
              name: 'Arwa Emam',
              profession: 'Student',
            ),
            icons()
          ],
        ),
      ),
    );
  }
}