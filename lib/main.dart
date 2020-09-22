import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/page/home_page.dart';
import 'package:qrreaderapp/src/page/map_display.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reader',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'maps': (BuildContext context) => MapDisplay()
      },
      theme: ThemeData(primaryColor: Colors.amber),
    );
  }
}
