import 'dart:convert';
import 'package:News_app_test/Models/News.dart';
import 'package:News_app_test/Pages/NewsDetails.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemList extends StatefulWidget {
  List list;
  ItemList({this.list});

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  String type;
  List<String> list = [];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.list == null ? 0 : widget.list.length,
        /* physics: NeverScrollableScrollPhysics(),*/
        shrinkWrap: true,
        itemBuilder: (context, i) {
          if (widget.list[i].source.id == null &&
              widget.list[i].urlToImage == null &&
              widget.list[i].author == null &&
              widget.list[i].title == null &&
              widget.list[i].description == null &&
              widget.list[i].url == null &&
              widget.list[i].publishedAt == null) {
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Author : " + widget.list[i].author, style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 18
                          ),),
                          Text("Source : " + widget.list[i].source.name, style: TextStyle(
                            fontWeight: FontWeight.w500
                          ),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: FlatButton(
                        child: AnimatedContainer(
                            height: 35,
                            padding: EdgeInsets.all(5),
                            duration: Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color:Colors.grey.shade300,)
                            ),
                            child: Center(
                              child:Icon(Icons.favorite, color: Colors.red,),
                            )
                        ),
                        onPressed: () async {
                          SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                          Article savedArticle = Article(
                              source: widget.list[i].source,
                              author: widget.list[i].author,
                              title: widget.list[i].title,
                              description: widget.list[i].description,
                              url: widget.list[i].url,
                              urlToImage: widget.list[i].urlToImage,
                              publishedAt: widget.list[i].publishedAt,
                              content: widget.list[i].content);

                          String json = jsonEncode(savedArticle);
                          list.add(json);
                          prefs.setStringList('News', list);
                          Fluttertoast.showToast(
                              msg: "Please check the favorite list in the top right of screen",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 15,
                              fontSize: 10.0);
                        },
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