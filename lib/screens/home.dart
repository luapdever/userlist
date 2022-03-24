import 'dart:async';

import 'package:flutter/material.dart';

import 'package:userlist/components/appbar.dart';
import 'package:userlist/screens/AddUser.dart';

// import 'dart:convert';
// import "package:userlist/Https/request.dart";

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;
  var _user = [];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t) => { _date_time() });

  }

  String time_of_day = "Loading...";

  _date_time() {
    var now_time = DateTime.now();
    setState(() {
      time_of_day = now_time.hour.toString().padLeft(2, '0') + " : "
                  + now_time.minute.toString().padLeft(2, '0') + " : "
                  + now_time.second.toString().padLeft(2, '0');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("list_bg.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.softLight),
          )
        ),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Welcome !",
                  style: TextStyle(
                    color: Color(0xFF110068),
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  time_of_day,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("add_user");
                      },
                      child: const Text("Register")
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed("list_user");
                      },
                      child: const Text("View list")
                    ),
                  ],
                )
              ],
            )
          ),
        ),
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return Container();
  // }
}
