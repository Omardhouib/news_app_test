import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'Pages/NewsPage.dart';



void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      title: "Appsolute news App",
      home: new MyHomePage(title: 'Appsolute News App'),
    );
  }
}


