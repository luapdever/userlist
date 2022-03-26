import 'dart:async';
import 'package:flutter/material.dart';
import 'package:userlist/screens/home.dart';
import 'package:userlist/sql_db/sql_helper.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SQLHelper.db();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(17, 0, 104, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'splash.png',
              width: 80,
            ),
            const Divider(),
            const Text(
              "User list management",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0
              )
            )
          ],
        ),
      ),
    );
  }
}
