import 'dart:convert';
import 'package:News_app_test/Models/News.dart';
import 'package:News_app_test/TextUi/GradientText.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class favNewsPage extends StatefulWidget {
  const favNewsPage({key}) : super(key: key);

  @override
  _favNewsPageState createState() => _favNewsPageState();
}

class _favNewsPageState extends State<favNewsPage> {
  List<Article> listArticle = new List<Article>();

  bool init = true;
  @override
  Widget build(BuildContext context) {
    fav();
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.blue,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
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
              itemCount: listArticle.length,
              /* physics: NeverScrollableScrollPhysics(),*/
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return Container(
                    margin:
                    EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
                    child: new Card(
                      color: Colors.grey[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2.0,
                      child: new Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(listArticle[i].urlToImage),
                                )),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Author : " + listArticle[i].author, style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 18
                                ),),
                                Text("Source : " + listArticle[i].source.name, style: TextStyle(
                                    fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
              }),
        ],
      ),
    );
  }

  fav() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    List<String> favt = sharedPreferences.getStringList('News');
    if (init) {
      favt.forEach((element) {
        listArticle.add(Article.fromJson(json.decode(element)));
      });
      init = false;
    }
    setState(() {});
    return favt;
  }
}


