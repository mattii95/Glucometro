import 'package:flutter/material.dart';
import 'package:projecto_glucometro/src/pages/detail_page.dart';
import 'package:projecto_glucometro/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glucometro',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'detail': (BuildContext context) => DetailPage(),
      },
    );
  }
}
