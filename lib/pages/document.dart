import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'transaction.dart';

class DocPage extends StatefulWidget {
  DocPage({Key key, this.id, this.name, this.bw, this.cl, this.jl})
      : super(key: key);
  final String id, name, bw, cl, jl;
  @override
  _DocPageState createState() => _DocPageState();
}

class _DocPageState extends State<DocPage> {
  String _fileName, path, email, nama;
  File file;
  TextEditingController _jmlHlm = TextEditingController();
  TextEditingController _jmlBrw = TextEditingController();
  bool colVal = false;
  bool jilVal = false;
  var prcBw, prcJl, prcCl;
  var sum1 = 0;
  var sum2 = 0;
  var sum3 = 0;
  var sumTot = 0;

  @override
  void initState() {
    super.initState();
    prcBw = int.parse(widget.bw);
    prcCl = int.parse(widget.cl);
    prcJl = int.parse(widget.jl);
    _getEmail();
  }

  _getEmail() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      nama = prefs.getString('nama');
    });
  }

  void _openFileExplorer() async {
    try {
      file = await FilePicker.getFile(type: FileType.ANY);
      print(file.path);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;

    setState(() {
      _fileName = basename(file.path);
    });
  }

  Future upload(File file) async {
    Navigator.of(this.context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }));
    var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length();
    var uri = Uri.parse("http://172.20.10.14:8080/cetak/upload.php");

    var request = new http.MultipartRequest("POST", uri);

    var multiPartFile = new http.MultipartFile("berkas", stream, length,
        filename: widget.name+"_"+basename(file.path));
    try {
      request.fields['nama'] = nama;
      request.fields['email'] = email;
      request.fields['file'] = basename(file.path);
      request.fields['store'] = widget.name;
      request.fields['total'] = sumTot.toString();
      request.fields['hitam'] = prcBw.toString();
      request.fields['warna'] = prcCl.toString();
      if(jilVal == true){
        request.fields['jilid'] = "biru";
      }
      request.fields['status'] = "unpaid";
      request.files.add(multiPartFile);
      var response = await request.send();
      if (response.statusCode == 200) {
        print("Success");
      } else {
        throw Exception('Error');
      }
    } catch (Exception) {
      //Handle Exception
    } finally {
      Navigator.pushAndRemoveUntil(this.context, MaterialPageRoute(builder: (BuildContext context) => TransPage(email:email)), (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: const Text('Print Document'),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(5.0),
          child: RaisedButton(
            onPressed: () {
              setState(() {
                upload(file);
              });
            },
            color: Colors.blue,
            textColor: Colors.white,
            child: Text(
              'PRINT NOW',
              style: new TextStyle(fontSize: 20.0),
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
          child: SingleChildScrollView(
            child: new Center(
              child: _fileName == null
                  ? new Column(
                      children: <Widget>[
                        new Container(
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: new Text("Select File"),
                            )),
                        new RaisedButton.icon(
                          label: Text("Pilih File"),
                          onPressed: _openFileExplorer,
                          icon: Icon(Icons.touch_app),
                        )
                      ],
                    )
                  : new Column(
                      children: <Widget>[
                        new Container(
                            height: 100,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('images/word.png',
                                    height: 40.0, width: 40.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(_fileName,
                                      style: new TextStyle(fontSize: 18.0)),
                                )
                              ],
                            )),
                        new RaisedButton.icon(
                          label: Text("Ganti File"),
                          onPressed: _openFileExplorer,
                          icon: Icon(Icons.touch_app),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: new Container(
                            height: 15.0,
                            color: Colors.grey[200],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: new Container(
                              alignment: Alignment.centerLeft,
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Text("Tambahan",
                                      style: new TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500)),
                                  new Container(child: Divider()),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            child: new Row(
                                              children: <Widget>[
                                                Text("Jumlah Halaman Hitam : ",
                                                    style: TextStyle(
                                                        fontSize: 16.0)),
                                                Container(
                                                  decoration: new BoxDecoration(
                                                      border: new Border.all(
                                                          color: Colors.grey,
                                                          width: 0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                                  width: 50.0,
                                                  child: TextField(
                                                      controller: _jmlHlm,
                                                      onChanged: (text) {
                                                        setState(() {
                                                          sum1 = int.parse(
                                                                  _jmlHlm
                                                                      .text) *
                                                              prcBw;
                                                          sumTot = sum1 +
                                                              sum2 +
                                                              sum3;
                                                        });
                                                      },
                                                      decoration:
                                                          new InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: new TextStyle(
                                                          fontSize: 15.0),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      textInputAction:
                                                          TextInputAction.done),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: 100.0,
                                          child: Text("Rp $sum1",
                                              style: new TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w100)),
                                        )
                                      ],
                                    ),
                                  ),
                                  new Row(
                                    children: <Widget>[
                                      Checkbox(
                                        value: colVal,
                                        onChanged: (bool value) {
                                          setState(() {
                                            colVal = value;
                                            if (value == false) {
                                              sumTot = sum1 + sum3;
                                            } else {
                                              sumTot = sum1 + sum2 + sum3;
                                            }
                                          });
                                        },
                                      ),
                                      Text(
                                        "Berwarna ? ",
                                        style: new TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  colVal == false
                                      ? Container(
                                          width: 100,
                                        )
                                      : Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text("Jumlah Berwarna : ",
                                                        style: TextStyle(
                                                            fontSize: 16.0)),
                                                    new Container(
                                                      decoration:
                                                          new BoxDecoration(
                                                              border:
                                                                  new Border
                                                                          .all(
                                                                      color: Colors
                                                                          .grey,
                                                                      width:
                                                                          0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                      width: 50.0,
                                                      child: TextField(
                                                        onChanged: (text) {
                                                          setState(() {
                                                            sum2 = int.parse(
                                                                    _jmlBrw
                                                                        .text) *
                                                                prcCl;
                                                            sumTot = sum1 +
                                                                sum2 +
                                                                sum3;
                                                          });
                                                        },
                                                        controller: _jmlBrw,
                                                        decoration:
                                                            new InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: new TextStyle(
                                                            fontSize: 15.0),
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              width: 150.0,
                                              child: Text("Rp $sum2",
                                                  style: new TextStyle(
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w100)),
                                            )
                                          ],
                                        ),
                                  new Row(
                                    children: <Widget>[
                                      Checkbox(
                                        value: jilVal,
                                        onChanged: (bool value) {
                                          setState(() {
                                            jilVal = value;
                                            if (value == false) {
                                              sumTot = sum1 + sum2;
                                            } else {
                                              sum3 = prcJl;
                                              sumTot = sum1 + sum2 + sum3;
                                            }
                                          });
                                        },
                                      ),
                                      Text(
                                        "Jilid ? ",
                                        style: new TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30.0),
                                    child: jilVal == false
                                        ? Container(
                                            width: 100,
                                          )
                                        : Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  child: new DropdownButton<
                                                      String>(
                                                    items: <String>[
                                                      'Merah',
                                                      'Biru',
                                                      'Hijau',
                                                      'Ungu'
                                                    ].map((String value) {
                                                      return new DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: new Text(value),
                                                      );
                                                    }).toList(),
                                                    onChanged: (_) {},
                                                    hint: Text("Warna Cover"),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                width: 150.0,
                                                child: Text("Rp $prcJl",
                                                    style: new TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.w100)),
                                              )
                                            ],
                                          ),
                                  )
                                ],
                              )),
                        ),
                        new Container(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20.0, 20.0, 0),
                          child: new Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text("Total",
                                          style: new TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w700))),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: 150.0,
                                  child: Text("Rp $sumTot",
                                      style: new TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500)),
                                )
                              ]),
                        ),
                      ],
                    ),
            ),
          ),
        ));
  }
}
