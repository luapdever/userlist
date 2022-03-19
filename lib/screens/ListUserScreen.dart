import 'package:flutter/material.dart';
import 'package:userlist/components/appbar.dart';
import 'package:userlist/screens/UserScreen.dart';
import 'dart:convert';
import "package:userlist/Https/request.dart";

class ListUserScreen extends StatefulWidget {
  ListUserScreen({Key? key}) : super(key: key);

  @override
  State<ListUserScreen> createState() => _ListUserScreenState();
}

class _ListUserScreenState extends State<ListUserScreen> {

  List<Map<String, Object>>? _list_user;
  late SearchDelegate<String> _delegate;

  @override
  void initState() {
    super.initState();
    
    setState(() {
      _list_user = [
        {
          "id" : 1,
          "first_name" : "Luap",
          "name" : "Dever",
          "birthday" : DateTime.now(),
          "adress" : "Ad058 Est",
          "phone" : "22951486388",
          "mail" : "example@gmail.com",
          "gender" : "masculin",
          "picture" : "http://localhost:8000/img/test.jpg",
          "citation" : "Take more courage for flying high"
        },
        {
          "id" : 2,
          "first_name" : "Luap 2",
          "name" : "Dever",
          "birthday" : DateTime.now(),
          "adress" : "Ad058 Est",
          "phone" : "22951486388",
          "mail" : "example@gmail.com",
          "gender" : "masculin",
          "picture" : "http://localhost:8000/img/test.jpg",
          "citation" : "Take more courage for flying high"
        },
        {
          "id" : 1,
          "first_name" : "Luap 3",
          "name" : "Dever",
          "birthday" : DateTime.now(),
          "adress" : "Ad058 Est",
          "phone" : "22951486388",
          "mail" : "example@gmail.com",
          "gender" : "masculin",
          "picture" : "http://localhost:8000/img/test.jpg",
          "citation" : "Take more courage for flying high"
        },
      ];
    });
  }

  Widget _buildRow(var user) {
    return ListTile(
      leading: CircleAvatar(
        child: Image.network(user["picture"]),
      ),
      title: Text(user["first_name"].toString() + " " + user["name"]),
      trailing: IconButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => UserScreen()
            )
          );
        },
        icon: const Icon(Icons.more_outlined)
      ),
    );
  }


  void _search(text) {
    setState(() {
      _list_user = (_list_user!.where((user) {
        return user["first_name"].toString().contains(text) || user["name"].toString().contains(text);
      })).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titlePage: "List", context: context),
      body: Container(
        child: Column(
          children: [
            Title(
              color: const Color.fromRGBO(17, 0, 104, 1),
              child: Text("List of users")
            ),
            ListView.builder(
              itemCount: _list_user!.length,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, index) {
                var user = _list_user![index];
                return _buildRow(user);
              }
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() async{
          final String? textSearch = await showSearch(
            context: context,
            delegate: _delegate
          );

          if(mounted && textSearch!=null) {
            _search(textSearch);
          }
        },
      ),
    );
  }
}