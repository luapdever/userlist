import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:userlist/Models/Arguments/UserArguments.dart';
import 'package:userlist/Models/User.dart';
import 'package:userlist/components/appbar.dart';
import 'package:userlist/sql_db/sql_helper.dart';


class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "UserList",
      onGenerateRoute: (settings) {
        final args = ModalRoute.of(context)!.settings.arguments as UserArguments;

        return MaterialPageRoute(
            builder: (context) {
              return MainScreen(idUser: args.id, fullName: args.fullName);
            },
        );
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  late int idUser;
  late String fullName;

  MainScreen({Key? key, required this.idUser, required this.fullName }) : super(key: key);

  @override
  State<MainScreen> createState() => _UserState();
}

class _UserState extends State<MainScreen> {

  Map<String, dynamic> _user = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    SQLHelper.getItem(widget.idUser).then((value) {
      setState(() {
        _user = value[0];
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: BaseAppBar(titlePage: widget.fullName, context: context),
      body: isLoading 
        ? const Center(
          child: CircularProgressIndicator(),
        )
        : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.file(
                    File(_user["picture"].toString()),
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  Title(
                    color: const Color.fromRGBO(17, 0, 104, 1),
                    child: Text(
                      User.getFullName(_user),
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ),
                  const SizedBox(height: 20),
                  Text(_user["citation"].toString()),
                  const SizedBox(height: 20),
                  Card(child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(width: 5),
                        Text(_user["gender"].toString())
                      ],
                    ),
                  )),
                  Card(child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.date_range),
                        const SizedBox(width: 5),
                        Text(_user["birthday"].toString())
                      ],
                    ),
                  )),
                  Card(child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.email),
                        const SizedBox(width: 5),
                        Text(_user["mail"].toString())
                      ],
                    ),
                  )),
                  Card(child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.phone),
                        const SizedBox(width: 5),
                        Text(_user["phone"].toString())
                      ],
                    ),
                  )),
                  Card(child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.location_city),
                        const SizedBox(width: 5),
                        Text(_user["adress"].toString())
                      ],
                    ),
                  )),
                ],
              )
            ),
          ),
        ),
    );
  }
}