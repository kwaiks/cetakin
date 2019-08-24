import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class AccountPage extends StatefulWidget{
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>{

  GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

  _logOut() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    _googleSignIn.disconnect();
    Navigator.push(context, new MaterialPageRoute(builder: (context) => LoginPage()));
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: RaisedButton(
          onPressed: _logOut,
          child: Text('Keluar'),
        ),
      )
    );
  }
}