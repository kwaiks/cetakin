import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show get;

class Store {
  final String id,storename,location,open,pricebw,pricecl,pricejl,pic;

  Store ({
    this.id,
    this.storename,
    this.location,
    this.open,
    this.pricebw,
    this.pricecl,
    this.pricejl,
    this.pic
  });

factory Store.fromJson(Map<String, dynamic> jsonData){
  return Store(
    id: jsonData['id'],
    storename: jsonData['storename'],
    location: jsonData['location'],
    open: jsonData['open'],
    pricebw: jsonData['pricebw'],
    pricecl: jsonData['pricecl'],
    pricejl: jsonData['pricejl'],
    pic: jsonData['pic'],
  );
 }
}

Future<List<Store>> downloadJSON() async {
    
    final jsonEndPoint = 
    "http://172.20.10.14:8080/cetak/store.php";

    final response = await get(jsonEndPoint);

    if(response.statusCode == 200){
      List store = json.decode(response.body);
      return store 
        .map((store) => new Store.fromJson(store))
        .toList();
    }else{
    throw Exception('Error');
  }
  }
