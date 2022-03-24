import 'package:flutter/material.dart';
import 'dart:convert';
import "package:userlist/Https/request.dart";
import 'package:userlist/Models/Arguments/UserArguments.dart';
import 'package:userlist/Models/User.dart';
import 'package:userlist/components/appbar.dart';


class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        final args = ModalRoute.of(context)!.settings.arguments as UserArguments;

        return MaterialPageRoute(
            builder: (context) {
              return MainScreen(idUser: args.id);
            },
        );
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  late int idUser;

  MainScreen({Key? key, required this.idUser }) : super(key: key);

  @override
  State<MainScreen> createState() => _UserState();
}

class _UserState extends State<MainScreen> {

  Map<String, Object> _user = {};

  @override
  void initState() {
    super.initState();

    setState(() {
      _user = User().get_user(widget.idUser);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: BaseAppBar(titlePage: "User " + widget.idUser.toString(), context: context,),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(
                    _user["picture"].toString(),
                    loadingBuilder: (context, child, loadingProgress) {
                      if(loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: Column(
                            children: const [
                              SizedBox(height: 20),
                              CircularProgressIndicator(),
                              SizedBox(height: 20),
                              Text("Loading image")
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Title(
                    color: const Color.fromRGBO(17, 0, 104, 1),
                    child: Text(
                      _user["first_name"].toString() + _user["name"].toString(),
                      style: const TextStyle(
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
    );
  }
}