import 'package:flutter/material.dart';
import 'package:share_plus/share.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatefulWidget {
  NewsDetails(
      {Key key,
      this.author,
      this.title,
      this.description,
      this.url,
      this.image,
      this.date})
      : super(key: key);
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Stack(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    child: Image.network(widget.image),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 10, 0),
                      child: IconButton(
                        icon: Icon(
                          Icons.share,
                          size: 35,
                        ),
                        onPressed: () {
                          Share.share(widget.url);
                        },
                      )),
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Text(
                widget.author,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
              child: Text(
                widget.description,
                style: TextStyle(fontSize: 15, color: Colors.grey),
              )),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: _launchURL,
                child: new Text("Read More ...",style: TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 17
                ),),
              ),
            ),
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
