import 'package:flutter/material.dart';
import 'package:cetakin/services/store.dart';
import 'document.dart';

class StorePickPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: Text('Pilih Toko'),),
      body: new Center(
          child: new FutureBuilder<List<Store>>(
        future: downloadJSON(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Store> data = snapshot.data;
            return new CustomListView(data);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return new CircularProgressIndicator();
        },
      )),
    );
  }
}

class CustomListView extends StatelessWidget {
  final List<Store> store;
  CustomListView(this.store);

  Widget build(context) {
    return ListView.builder(
      itemCount: store.length,
      itemBuilder: (context, int currentIndex) {
        return createViewItem(store[currentIndex], context);
      },
    );
  }

  Widget createViewItem(Store store, BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(builder: (context) => DocPage(id:store.id, bw:store.pricebw, name:store.storename, cl:store.pricecl, jl:store.pricejl)));
          },
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 130.0,
                  width: 400.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/aa.jpg"),
                        fit: BoxFit.fitWidth,
                      ),
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        store.storename,
                        style: new TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: new Row(
                          children: <Widget>[
                            Icon(Icons.location_on, size: 18.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(store.location,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w100)),
                            )
                          ],
                        ),
                      ),
                      new Row(
                        children: <Widget>[
                          Icon(Icons.timer, size: 18.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              store.open,
                              style: new TextStyle(fontWeight: FontWeight.w100),
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
    );
  }
}
