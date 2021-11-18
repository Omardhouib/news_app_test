import 'package:News_app_test/Models/News.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share.dart';
import 'package:url_launcher/url_launcher.dart';


class NewsDetails extends StatefulWidget {
  NewsDetails({Key key, this.author, this.title, this.description, this.url, this.image, this.date}) : super (key: key);
  String author;
  String title;
  String description;
 final String url;
  String image;
  DateTime date;


  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: SizedBox(
              width: 500,
              height: 200,
              child: Image.network(widget.image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Text(
              widget.author,
              style: TextStyle(fontSize: 30),
            )
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 20),
              )
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
              child: Text(
                widget.description,
                style: TextStyle(fontSize: 15),
              )
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: IconButton(
                icon: Icon(Icons.share),
                onPressed: (){
              Share.share(widget.url);
                },
              )
          ),
          RaisedButton(
            onPressed: _launchURL,
            child: Text('Show Flutter homepage'),
          ),
        ],
      ),
    );


  }
 void _launchURL() async {
    String urll = widget.url;
    if (await canLaunch(urll)) {
      await launch(urll);
    } else {
      throw 'Could not launch $urll';
    }
  }
}

