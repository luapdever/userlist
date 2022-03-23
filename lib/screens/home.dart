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
      
      appBar: BaseAppBar(titlePage: "UserList", context: context,),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Title(
                    color: const Color.fromRGBO(17, 0, 104, 1),
                    child: const Text(
                      "Welcome !",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ),
                  const SizedBox(height: 10),
                  Text(
                    time_of_day,
                    style: const TextStyle(
                      color: Color.fromRGBO(17, 0, 104, 1),
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text("Click here to sign in."),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => AddUserScreen()
                        )
                      );
                    },
                    child: Text("Register")
                  )
                ],
              )
            ),
          ),
        )
    );
  }
  // Widget build(BuildContext context) {
  //   return Container();
  // }
}
