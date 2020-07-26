import 'package:flutter/material.dart';
import 'package:cupos_uis/src/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cupos Uis',
        debugShowCheckedModeBanner: false,
        home: HomePage());
  }
}
