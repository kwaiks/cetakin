import 'package:flutter/material.dart';
import 'package:cetakin/services/trans.dart';
import 'package:cetakin/main.dart';

class TransPage extends StatefulWidget{
  TransPage({Key key, this.email})
      : super(key: key);
  final String email;
  @override
  _TransPageState createState()=> _TransPageState();
}



class _TransPageState extends State<TransPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: Text('Pilih Toko'),),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(5.0),
          child: RaisedButton(
            onPressed: () {
              setState(() {
                Navigator.pushAndRemoveUntil(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    MyHomePage()),(Route<dynamic> route) => false);
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
      body: new Center(
          child: new FutureBuilder<List<Trans>>(
        future: downloadJSON(widget.email),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Trans> data = snapshot.data;
              return new MainBody(data);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return new CircularProgressIndicator();
        },
      )),
    );
  }
}

class MainBody extends StatelessWidget {
  final List<Trans> trans;
  MainBody(this.trans);

  Widget build(context) {
    return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 20.0),
                    alignment: Alignment.center,
                    child: new Text("Transaksi Berhasil !", style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700))),
                Container(
                  child: Divider(),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text("Detail", style: new TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700)),
                        ),
                        Text("Toko", style: new TextStyle(fontSize: 20.0)),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(trans[0].store, style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
                        ),
                        Text("Jumlah Halaman Hitam Putih", style: new TextStyle(fontSize: 14.0)),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(trans[0].hitam+" Lembar", style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
                        ),
                        Text("Jumlah Halaman Berwarna", style: new TextStyle(fontSize: 14.0)),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(trans[0].warna+" Lembar", style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
                        ),
                        Text("Jilid", style: new TextStyle(fontSize: 16.0)),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(trans[0].jilid, style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    )),
                Container(
                  child: Divider(),
                ),
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
                          child: Text("Rp "+ trans[0].total,
                              style: new TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w500)),
                        )
                      ]),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  alignment: Alignment.centerLeft, child: Text("Dokumen anda akan siap dalam 5 menit", style: new TextStyle(fontWeight: FontWeight.w300),)),
              ],
            ),
          )
    ;
  }

}
