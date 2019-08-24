import 'package:flutter/material.dart';
import 'package:cetakin/pages/home.dart';
import 'package:cetakin/pages/account.dart';
import 'package:cetakin/pages/history.dart';
import 'package:cetakin/pages/login.dart';
import 'package:cetakin/pages/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(CetakIn());

class CetakIn extends StatelessWidget {

  Future<bool> getLoginStatus() async{
    final prefs = await SharedPreferences.getInstance();
    bool loginStatus = prefs.getBool('login') ?? false;
    print('login status $loginStatus');
    return loginStatus;
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    HistoryPage(),
    AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            new BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home")
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              title: Text("History"),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Account")
            )
          ],
        ),
      body: _children[_currentIndex], // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }
}
