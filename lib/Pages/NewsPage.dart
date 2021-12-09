import 'package:News_app_test/Models/News.dart';
import 'package:News_app_test/Pages/FavNewsPage.dart';
import 'package:News_app_test/Pages/NewsItemList.dart';
import 'package:News_app_test/TextUi/GradientText.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var controller = TextEditingController();
  String textSearch = "";
  bool initList = true;
  bool isLoading = false;
  List<dynamic> listsearch = List<dynamic>();
  List<Article> searchNews = List<Article>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [new FlatButton(
        child: AnimatedContainer(
        height: 35,
            padding: EdgeInsets.all(5),
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color:Colors.grey.shade200,)
            ),
            child: Center(
              child:Icon(Icons.favorite, color: Colors.red),
            )
        ),
              onPressed:(){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => favNewsPage()));
          }),
          ],
          title: Container(
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
        backgroundColor: Colors.white,
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Card(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width - 30,
                          child: ListTile(
                            leading: new Icon(Icons.search, color: Colors.lightBlue,size: 30,),
                            title: new TextField(
                              controller: controller,
                              decoration: new InputDecoration(
                                  hintText: 'Chercher news ...',
                                  border: InputBorder.none),
                              onChanged: (input) {
                                setState(() {
                                  if (input.isEmpty) {
                                    textSearch = null;
                                    initList = true;
                                  } else {
                                    textSearch = input;
                                    initList = false;
                                    print(input);
                                  }
                                });
                              },
                            ),
                            trailing: new IconButton(
                              color: textSearch == null
                                  ? Colors.white
                                  : Colors.grey,
                              icon: new Icon(Icons.cancel),
                              onPressed: () {
                                setState(() {
                                  textSearch = null;
                                  initList = true;
                                });
                                controller.clear();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            isLoading
                ? Container() :
                FutureBuilder<News>(
                    future: AllNews(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                      }
                      if (snapshot.hasData) {
                        if (textSearch != "" && initList == false) {
                          print(snapshot.data.articles.length);
                          print(textSearch);
                          snapshot.data.articles.removeWhere((element) =>
                              element
                                  .toString()
                                  .toLowerCase()
                                  .contains(textSearch.toLowerCase()) ==
                              false);
                          print(snapshot.data.articles.length);
                        }
                        return ItemList(list: snapshot.data.articles);
                      } else {
                        return Container();
                      }
                    }),
          ],
        ));
  }

  Future<News> AllNews() async {
    var news;
    setState(() {
      isLoading = true;
    });
    String ApiKey = "6fd07d4dab3a473b91c078235cebf1a2";
    var options = BaseOptions(
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    var dio = Dio(options);
    String myUrl =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$ApiKey";
    var response = await dio.get(myUrl);

    if (response.statusCode == 200) {
      news = News.fromJson(response.data);
    } else {
      // then throw an exception.
      throw Exception('Failed to load news');
    }
    setState(() {
      isLoading = false;
    });
    return news;
  }
}

