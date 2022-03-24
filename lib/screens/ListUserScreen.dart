import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:userlist/Models/Arguments/UserArguments.dart';
import 'package:userlist/Models/User.dart';
import 'package:userlist/components/appbar.dart';
import 'dart:convert';
import "package:userlist/Https/request.dart";

class ListUserScreen extends StatefulWidget {
  ListUserScreen({Key? key}) : super(key: key);

  @override
  State<ListUserScreen> createState() => _ListUserScreenState();
}

class _ListUserScreenState extends State<ListUserScreen> {

  List<Map<String, Object>> _list_user = [];
  late SearchDelegate<String> _delegate;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    
    setState(() {
      _list_user = User().get_list();

      isLoading = false;
    });
  }

  Widget _buildRow(var user) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(
            "user",
            arguments: UserArguments(user["id"], user["first_name"] + user["name"])
          );
        },
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user["picture"]),
        ),
        title: Text(user["first_name"].toString() + " " + user["name"]),
        subtitle: Text(user["mail"]),
        trailing: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              "user",
              arguments: UserArguments(user["id"], user["first_name"] + user["name"])
            );
          },
          icon: const Icon(Icons.remove_red_eye_outlined)
        ),
      ),
    );
  }


  void _search(text) {
    setState(() {
      _list_user = (_list_user.where((user) {
        return user["first_name"].toString().contains(text) || user["name"].toString().contains(text);
      })).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titlePage: "List", context: context),
      body: isLoading == true ? 
        Center(child: Text("loading..")) : Container(
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
              ListView.builder(
                itemCount: _list_user.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (context, index) {
                  var user = _list_user[index];
                  return _buildRow(user);
                }
              )
            ],
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