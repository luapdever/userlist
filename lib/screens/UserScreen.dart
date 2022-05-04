import 'dart:io';

import 'package:flutter/material.dart';
import 'package:userlist/Https/network.dart';
import 'dart:convert';
import 'package:userlist/Models/Arguments/UserArguments.dart';
import 'package:userlist/Models/User.dart';
import 'package:userlist/components/appbar.dart';
import 'package:userlist/screens/home.dart';
import 'package:userlist/sql_db/sql_helper.dart';
import 'package:userlist/screens/AddUser.dart';
import 'package:userlist/screens/ListUserScreen.dart';
import 'package:userlist/screens/UpdateUserScreen.dart';
import 'package:userlist/screens/albums.dart';
import 'package:userlist/screens/members.dart';


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

class MainScreen extends StatefulWidget {
  late String idUser;
  late String fullName;

  MainScreen({Key? key, required this.idUser, required this.fullName }) : super(key: key);

  @override
  State<MainScreen> createState() => _UserState();
}

class _UserState extends State<MainScreen> {

  Map<String, dynamic> _user = {"id": null};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // SQLHelper.getItem(widget.idUser).then((value) {
    //   setState(() {
    //     _user = value[0];
    //     isLoading = false;
    //   });
    // });

    HTTPNetwork.getUser(widget.idUser).then((value) {
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
        ? Center( child: Column(mainAxisAlignment: MainAxisAlignment.center ,children: const[
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Loading, wait...")
          ]),
        )
        : (_user["id"] == null ? 
          const Center(
            child: Text("This user don't exist"),
          )
         : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  User.Picture(_user["picture"]),
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        "update_user",
                        arguments: UserArguments(_user["id"], User.getFullName(_user))
                      );
                    },  
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Edit "),
                        Icon(Icons.edit),
                      ]
                    )
                  ),
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
                  // Card(child: Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: Row(
                  //     children: [
                  //       const Icon(Icons.date_range),
                  //       const SizedBox(width: 5),
                  //       Text(_user["birthday"].toString())
                  //     ],
                  //   ),
                  // )),
                  // Card(child: Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: Row(
                  //     children: [
                  //       const Icon(Icons.email),
                  //       const SizedBox(width: 5),
                  //       Text(_user["mail"].toString())
                  //     ],
                  //   ),
                  // )),
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
        )),
    );
  }
}