import 'package:News_app_test/Models/News.dart';
import 'package:News_app_test/Pages/NewsDetails.dart';
import 'package:News_app_test/Services/DataHelpers.dart';
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
  DataHelpers DataHelperss = new DataHelpers();
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
                          width: MediaQuery.of(context).size.width -30,
                          child: ListTile(
                            leading: new Icon(Icons.search),
                            title: new TextField(
                              controller: controller,
                              decoration: new InputDecoration(
                                  hintText: 'Chercher', border: InputBorder.none),
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
                              color:
                                  textSearch == null ? Colors.white : Colors.grey,
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
                isLoading?
    CircularProgressIndicator():
            // _buildList(),
            FutureBuilder<News>(
                future: AllNews(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                  }
                  if (snapshot.hasData) {
                    if (textSearch != "" && initList == false){
                      print(snapshot.data.articles.length);
                      print(textSearch);
                     /* snapshot.data.articles.forEach((element) {
                        print(element.toString());
                        print(textSearch);
                      });*/
                    snapshot.data.articles.removeWhere((element) =>
                        element
                            .toString().toLowerCase()
                            .contains(textSearch.toLowerCase()) ==
                        false
                    );
                      print(snapshot.data.articles.length);
                    }
                    return ItemList(list: snapshot.data.articles);
                  } else {
                    return Container(
                      child: Text('hiiiiiiiiiiii'),
                    );
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
    var dio = Dio();
    String myUrl = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$ApiKey";
    var response = await dio.get(
      myUrl,
    );
    if (response.statusCode == 200) {
      /*print("lllllll"+json.decode(response.data).toString());*/
      news =  News.fromJson(response.data);
    } else {
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    setState(() {
      isLoading = false;
    });
    return news;
  }

}





class ItemList extends StatefulWidget {
  List list;
  final List<String> searchNews;
  ItemList({this.list, this.searchNews});

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  String type;
  void _onValueChange(String value) {
    setState(() {
      _selectedId = value;
    });
  }

  String _selectedId;
  ScrollController _controller = new ScrollController();
  DataHelpers DataHelperss = new DataHelpers();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.list == null ? 0 : widget.list.length,
        /* physics: NeverScrollableScrollPhysics(),*/
        shrinkWrap: true,
        itemBuilder: (context, i) {
          if (widget.list[i].source.id == null &&
              widget.list[i].urlToImage == null) {
            return Container();
          }
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewsDetails(
                          author: widget.list[i].author,
                          title: widget.list[i].title,
                          description: widget.list[i].description,
                          url: widget.list[i].url,
                          image: widget.list[i].urlToImage,
                          date: widget.list[i].publishedAt)));
            },
            child: new Container(
              margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
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
                            child: Image.network(widget.list[i].urlToImage),
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text("Author : " + widget.list[i].author),
                          Text(
                            "title " + widget.list[i].title.toString(),
                            style: new TextStyle(
                                color: Colors.black, fontSize: 18.0),
                          ),
                          Text("Source : " + widget.list[i].source.name),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
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
