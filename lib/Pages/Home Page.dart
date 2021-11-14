import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 // List<Post> postList = [];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
          style: TextStyle(
          fontSize: 25,
        ),),
      ),
      backgroundColor: Colors.grey[200],
       body: Container(
          child: new ListView.builder(
              itemCount: 20,

              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return _getPostWidgets(index);
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
