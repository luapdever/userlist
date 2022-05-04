import 'package:userlist/screens/AddUser.dart';
import 'package:userlist/screens/ListUserScreen.dart';
import 'package:userlist/screens/UpdateUserScreen.dart';
import 'package:userlist/screens/UserScreen.dart';
import 'package:userlist/screens/albums.dart';
import 'package:userlist/screens/members.dart';

import '/screens/home.dart';
import '/screens/splash.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "UserList",
      //home: RegisterScreen(),
      home: StartApp(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "home": (context) => HomeScreen(),
        "list_user": (context) => ListUserScreen(),
        "add_user": (context) => AddUserScreen(),
        "user": (context) => UserScreen(),
        "update_user": (context) => UpdateUserScreen(),
        "members":(context) => const MembersScreen(),
        "albums":(context) => AlbumsScreen()
      },
    );
  }
}

class StartApp extends StatefulWidget {
  @override
  _StartAppState createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
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
