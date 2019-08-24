import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cetakin/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);
class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState()=> _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  GoogleSignInAccount _currentUser;

  _getLoginStatus() async{
    final prefs = await SharedPreferences.getInstance();
    bool loginStatus = prefs.getBool('login');
    if(loginStatus == true){
      Navigator.push(context, new MaterialPageRoute(builder: (context) => MyHomePage()));
    }
    print(loginStatus);
  }

  @override
  void initState() {
    super.initState();
    _getLoginStatus();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
        _save();
      });
      if (_currentUser != null) {
        Navigator.push(context, new MaterialPageRoute(builder: (context) => MyHomePage()));
      }
    });
  }


  _save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('nama', _currentUser.displayName);
    prefs.setString('email', _currentUser.email);
    prefs.setBool('login', true);
    print(_currentUser.displayName);
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Widget _buildBody(){
    if (_currentUser == null) {
      return SafeArea(
          child: new Container(
        decoration: new BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.4, 1],
                colors: [Color(0xFF6DD5ED), Color(0xFF2193B0)])),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/print.png',
                height: 200.0,
                width: 200.0,
              ),
              Text("PRINT-IN",
                  style: new TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(top:30.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onPressed: _handleSignIn,
                      padding: EdgeInsets.all(5),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('images/google.png', height: 40.0, width: 40.0,),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 2.0),
                            child: Text('Login with Google', style: TextStyle(color: Colors.black54, fontSize: 15.0)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ));
    
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody());
  }
}
