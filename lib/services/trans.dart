import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show get;

class Trans {
  final String id,file,date,total,jilid,status,store,hitam,warna;

  Trans ({
    this.id,
    this.file,
    this.date,
    this.total,
    this.jilid,
    this.status,
    this.store,
    this.hitam,
    this.warna
  });

factory Trans.fromJson(Map<String, dynamic> jsonData){
  return Trans(
    id: jsonData['id'],
    file: jsonData['file'],
    date: jsonData['date'],
    total: jsonData['total'],
    status: jsonData['status'],
    store: jsonData['store'],
    hitam: jsonData['hitam'],
    warna: jsonData['warna'],
    jilid: jsonData['jilid']
  );
 }
}

Future<List<Trans>> downloadJSON(email) async {
    
    final jsonEndPoint = 
    "http://172.20.10.14:8080/cetak/trans.php?email=" + email;

    final response = await get(jsonEndPoint);

    if(response.statusCode == 200){
      List store = json.decode(response.body);
      return store 
        .map((store) => new Trans.fromJson(store))
        .toList();
    }else{
    throw Exception('Error');
  }
  }
