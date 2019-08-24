import 'package:flutter/material.dart';
import 'package:cetakin/theme/topbar.dart';
import 'package:cetakin/pages/storepick.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name;

  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  _getInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('nama');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: new Center(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    new Container(
                      child: TopBar(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Hi, $name",
                            style: new TextStyle(
                                fontSize: 24.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 70.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "What are you gonna print ?",
                            style: new TextStyle(
                                fontSize: 14.0, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(70.0, 100.0, 70.0, 0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: new Container(
                              height: 80.0,
                              padding: const EdgeInsets.all(10.0),
                              decoration: new BoxDecoration(
                                  color: Color(0xFFFAFAFA),
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    new BoxShadow(
                                        color: Colors.grey,
                                        offset: new Offset(0.0, 5.0),
                                        blurRadius: 10.0)
                                  ]),
                              child: new Row(
                                children: <Widget>[
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    StorePickPage()));
                                      },
                                      child: Container(
                                        child: new Column(
                                          children: <Widget>[
                                            Icon(
                                              Icons.description,
                                              size: 40.0,
                                            ),
                                            Text("Document")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  new Container(
                                    height: 50.0,
                                    child: VerticalDivider(
                                      color: Colors.grey,
                                      width: 30.0,
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        child: new Column(
                                          children: <Widget>[
                                            Icon(
                                              Icons.photo,
                                              size: 40.0,
                                            ),
                                            Text("Photo")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                  child: new Row(
                    children: <Widget>[
                      new Text(
                        "Recent Printed",
                        style: new TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Container(
                    height: 190.0,
                    child: new ListView(
                      children: <Widget>[
                        Card(
                          child: new Container(
                            padding: const EdgeInsets.all(5.0),
                            child: new Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'images/word.png',
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: new Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new Text(
                                            "Asco Jaya",
                                            style: new TextStyle(
                                                fontFamily: "Rock Salt",
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              new Text("wew.docx"),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "11/08/19",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.w100,
                                        color: Colors.grey),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: new Container(
                            padding: const EdgeInsets.all(5.0),
                            child: new Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'images/pdf.png',
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: new Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new Text(
                                            "Asco Jaya",
                                            style: new TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          new Text("waw.pdf")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "11/08/19",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.w100,
                                        color: Colors.grey),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                new Container(
                  height: 15.0,
                  color: Colors.grey[200],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                  child: new Row(
                    children: <Widget>[
                      new Text(
                        "Store Lists",
                        style: new TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                new Container(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  height: 240.0,
                  child: new ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Card(
                          child: InkWell(
                            onTap: () {
                              print("ea");
                            },
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 130.0,
                                    width: 300.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("images/aa.jpg"),
                                          fit: BoxFit.fitWidth,
                                          alignment: Alignment.bottomLeft,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "AA Foto Copy",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20.0),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2.0),
                                          child: new Row(
                                            children: <Widget>[
                                              Icon(Icons.location_on,
                                                  size: 18.0),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: Text(
                                                    'Jalan pondok Randu',
                                                    style: new TextStyle(
                                                        fontWeight:
                                                            FontWeight.w100)),
                                              )
                                            ],
                                          ),
                                        ),
                                        new Row(
                                          children: <Widget>[
                                            Icon(Icons.timer, size: 18.0),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Text(
                                                '08:00 - 21:00',
                                                style: new TextStyle(
                                                    fontWeight:
                                                        FontWeight.w100),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Card(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 130.0,
                                    width: 300.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("images/aa.jpg"),
                                          fit: BoxFit.fitWidth,
                                          alignment: Alignment.bottomLeft,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "ASCO JAYA",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20.0),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2.0),
                                          child: new Row(
                                            children: <Widget>[
                                              Icon(Icons.location_on,
                                                  size: 18.0),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: Text(
                                                    'Jalan pondok Randu',
                                                    style: new TextStyle(
                                                        fontWeight:
                                                            FontWeight.w100)),
                                              )
                                            ],
                                          ),
                                        ),
                                        new Row(
                                          children: <Widget>[
                                            Icon(Icons.timer, size: 18.0),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Text(
                                                '08:00 - 21:00',
                                                style: new TextStyle(
                                                    fontWeight:
                                                        FontWeight.w100),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
