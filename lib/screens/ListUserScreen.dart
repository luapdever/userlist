import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:userlist/Models/Arguments/UserArguments.dart';
import 'package:userlist/Models/User.dart';
import 'package:userlist/components/appbar.dart';
import 'dart:convert';
import "package:userlist/Https/request.dart";
import 'package:userlist/sql_db/sql_helper.dart';

class ListUserScreen extends StatefulWidget {
  ListUserScreen({Key? key}) : super(key: key);

  @override
  State<ListUserScreen> createState() => _ListUserScreenState();
}

class _ListUserScreenState extends State<ListUserScreen> {

  List<Map<String, dynamic>> _listUser = [];
  late SearchDelegate<String> _delegate;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    
    SQLHelper.getItems().then((value) {
      setState(() {
        _listUser = value;
        isLoading = false;
      });
    });
  }

  Widget _buildRow(var user) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            "user",
            arguments: UserArguments(user["id"], User.getFullName(user))
          );
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(user["picture"]),
          ),
          title: Text(User.getFullName(user)),
          subtitle: Text(user["mail"]),
          trailing: const Icon(Icons.remove_red_eye_outlined)
        ),
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titlePage: "List", context: context),
      body: isLoading ? 
        const Center(child: CircularProgressIndicator())
        : Container(
          padding: const EdgeInsets.only(
            top: 16.0
          ),
          child: Column(
            children: [
              Title(
                color: const Color.fromRGBO(17, 0, 104, 1),
                child: const Text(
                  "List of users",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
              _listUser.isEmpty 
              ? Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(8.0),
                child: const Text("No user for a moment."),
              )
              : ListView.builder(
                itemCount: _listUser.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (context, index) {
                  var user = _listUser[index];
                  return _buildRow(user);
                }
              )
            ],
          ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(17, 0, 104, 1),
        onPressed: () {
          Navigator.of(context).pushNamed("add_user");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}