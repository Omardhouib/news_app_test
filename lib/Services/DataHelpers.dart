import 'dart:developer';
import 'package:News_app_test/Models/News.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';

class DataHelpers {

  static String ApiKey = "6fd07d4dab3a473b91c078235cebf1a2";

  var dio = Dio();


  Future<News> AllNews() async {
    print("hihihihihi");
    String myUrl = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$ApiKey";
    print("hih");
   var response = await dio.get(
      myUrl,
      /*options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),*/
    );
    print("pppppp"+response.statusCode.toString());
    if (response.statusCode == 200) {
      /*print("lllllll"+json.decode(response.data).toString());*/
      return News.fromJson(response.data);
    } else {
      print("mmmmm");
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

}