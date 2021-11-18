import 'package:News_app_test/Models/News.dart';
import 'package:News_app_test/Pages/NewsDetails.dart';
import 'package:News_app_test/Services/DataHelpers.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   List<News> newsList = [];
  DataHelpers DataHelperss = new DataHelpers();
  Future<News> AllNews;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(

        child: FutureBuilder<News>(
            future: DataHelperss.AllNews(),
            builder: (context, snapshot) {
              print("hihihihihi");
              if (snapshot.hasError) {
                print("hihihihihi1111");
                print(snapshot.error);
                print("mochkla lenaa *");
              }
              if (snapshot.hasData) {
                print("hihihihihi2222");
                return ItemList(list: snapshot.data.articles);
              } else {
                return Container(
                  child: Text('hiiiiiiiiiiii'),
                );
              }
            }),
      ),
    );
  }

  Widget _getPostWidgets(int index) {
    // var post = postList[index];
    return new GestureDetector(
      onTap: () {
        // openDetailsUI(post);
      },
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: new Card(
          elevation: 3.0,
          child: new Row(
            children: <Widget>[
              new Container(
                width: 150.0,
                height: 70,
                child: Text("hello"),
                /*child: new CachedNetworkImage(
                  imageUrl: post.thumbUrl,
                  fit: BoxFit.cover,
                  placeholder: new Icon(
                    Icons.panorama,
                    color: Colors.grey,
                    size: 120.0,
                  ),
                ),*/
              ),
              new Expanded(
                  child: new Container(
                margin: new EdgeInsets.all(10.0),
                child: new Text(
                  "title",
                  style: new TextStyle(color: Colors.black, fontSize: 18.0),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  List list;
  ItemList({this.list});

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
        itemCount: widget.list == null ? 0 : widget.list.length,
       /* physics: NeverScrollableScrollPhysics(),*/
        shrinkWrap: true,
        itemBuilder: (context, i) {
          if(widget.list[i].source.id == null && widget.list[i].urlToImage == null){
            return Container();
          }
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewsDetails(author: widget.list[i].author,
                                                        title: widget.list[i].title,
                                                        description: widget.list[i].description,
                                                        url: widget.list[i].url,
                                                        image: widget.list[i].urlToImage,
                                                        date: widget.list[i].publishedAt
                      )));
            },
            child: new Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              child: new Card(
                elevation: 3.0,
                child: new Row(
                  children: <Widget>[
                    Container(
                      child: Image.network(widget.list[i].urlToImage),
                      height: 50,
                      width: 50,
                    ),

                    new Container(
                      width: 150.0,
                      height: 70,
                      child: Text("Source : "+widget.list[i].source.name),
                      /*child: new CachedNetworkImage(
                  imageUrl: post.thumbUrl,
                  fit: BoxFit.cover,
                  placeholder: new Icon(
                    Icons.panorama,
                    color: Colors.grey,
                    size: 120.0,
                  ),
                ),*/
                    ),
                    new Expanded(
                        child: new Container(
                      margin: new EdgeInsets.all(10.0),
                      child: new Text(
                        "title"+widget.list[i].title.toString(),
                        style:
                            new TextStyle(color: Colors.black, fontSize: 18.0),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
