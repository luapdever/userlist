import 'package:flutter/material.dart';
import 'dart:convert';
import "package:userlist/Https/request.dart";
import 'package:userlist/Models/Arguments/UserArguments.dart';
import 'package:userlist/components/appbar.dart';


class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        final args = settings.arguments as UserArguments;

        return MaterialPageRoute(
            builder: (context) {
              return User(id_user: args.id);
            },
          );
      },
    );
  }
}

class User extends StatefulWidget {
  late String id_user;

  User({Key? key, required String id_user }) : super(key: key);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: BaseAppBar(titlePage: "User" + widget.id_user, context: context,),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    "bg_img.png"
                  ),
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
                ],
              )
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("add_user");
          },
          child: const Icon(Icons.add),
        ),
    );
  }
}