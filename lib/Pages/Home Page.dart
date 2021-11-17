import 'package:News_app_test/Models/News.dart';
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
              // openDetailsUI(post);
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

          /*Container(
            height: 200,
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 0,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 00),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                      child: Row(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.developer_board,
                              color: Colors.white,
                            ),
                            radius: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              width: 250,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    //list[i].toString() ?? '',
                                    widget.list[i].name.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    //list[i].toString() ?? '',
                                    "Identifier: "+widget.list[i].sensorIdentifier.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                        color: Colors.grey
                                    ),
                                  ),
                                  Text(
                                    //list[i].toString() ?? '',
                                    "Type: "+widget.list[i].sensorType.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                        color: Colors.grey
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.green,
                                size: 27,
                              ),
                              onPressed: (){
                                showDialog(
                                    context: context,
                                    child: UpdateSens(
                                        onValueChange: _onValueChange,
                                        initialValue: _selectedId,
                                        identifier: widget.list[i].id,
                                        name: widget.list[i].name
                                    ));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: FutureBuilder(
//                future: databaseHelper.getData(),
                          future: databaseHelper2.getdataDeviceByID(widget.list[i].id),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              print(snapshot.error);
                              print("mochkla lenaa *");
                            }
                            if (snapshot.hasData) {
                              type = widget.list[i].sensorType;
                              return ChartLineClass(data: snapshot.data, type: type);
                            } else {
                              return Container();
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );*/
        });
  }
}
