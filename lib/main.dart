import '/screens/home.dart';
import '/screens/splash.dart';
import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/register.dart';
//import 'screens/home.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "UserList",
      //home: RegisterScreen(),
      home: CheckAuth(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool _isAuth = false;
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Widget child;
      child = SplashScreen();
    return Scaffold(
      body: child,
    );
  }
}
