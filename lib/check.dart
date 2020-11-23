import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homePage.dart';

void main() => runApp(Check());

class Check extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PPG',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: HomePage(),
    );
  }
}