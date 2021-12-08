import 'dart:convert';
import 'package:News_app_test/Models/News.dart';
import 'package:News_app_test/Services/DataHelpers.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class favNewsPage extends StatefulWidget {
  const favNewsPage({key}) : super(key: key);

  @override
  _favNewsPageState createState() => _favNewsPageState();
}

class _favNewsPageState extends State<favNewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          alignment: Alignment.center,
          child: GradientText(
            'Appsolute News',
            style: const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
            gradient: LinearGradient(colors: [
              Colors.indigo[800],
              Colors.purple[600],
              Colors.blue[600],
              Colors.blue[900],
              Colors.red
            ]),
          ),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: 6,
        /* physics: NeverScrollableScrollPhysics(),*/
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return Container(
            child: FlatButton(
              onPressed:(){
                print('ihihihih'+fav().toString());
              },
            )
          );
        }),
        ],
      ),
    );
  }

   fav() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    List<String> favt = sharedPreferences.getStringList('News');

    print("lissst"+(favt.toString()));
    return favt;
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
      this.text, {
        this.gradient,
        this.style,
      });

  final String text;
  final TextStyle style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}