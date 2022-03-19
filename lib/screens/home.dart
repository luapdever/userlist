import 'package:userlist/components/appbar.dart';
import 'package:userlist/screens/AddUser.dart';

import 'package:flutter/material.dart';
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


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: BaseAppBar(titlePage: "UserList", context: context,),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Title(
              color: const Color.fromRGBO(17, 0, 104, 1),
              child: Text("Welcome !")
            ),
            Text(TimeOfDay.now().toString()),
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
        ),
      )
    );
  }
  // Widget build(BuildContext context) {
  //   return Container();
  // }
}
