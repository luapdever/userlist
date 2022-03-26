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
                  Image.asset(
                    _user["picture"].toString(),
                    // loadingBuilder: (context, child, loadingProgress) {
                    //   if(loadingProgress == null) {
                    //     return child;
                    //   } else {
                    //     return Center(
                    //       child: Column(
                    //         children: const [
                    //           SizedBox(height: 20),
                    //           CircularProgressIndicator(),
                    //           SizedBox(height: 20),
                    //           Text("Loading image")
                    //         ],
                    //       ),
                    //     );
                    //   }
                    // },
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
                  const SizedBox(height: 30),
                  Card(child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.email),
                        Text(_user["picture"].toString())
                      ],
                    ),
                  ))
                ],
              )
            ),
          ),
        ),
    );
  }
}