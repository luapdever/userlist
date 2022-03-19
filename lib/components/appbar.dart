import 'package:flutter/material.dart';
import 'package:userlist/screens/AddUser.dart';
import 'package:userlist/screens/ListUserScreen.dart';


class BaseAppBar extends AppBar {
  
  final String titlePage;

  BaseAppBar({ Key? key, required this.titlePage, required BuildContext context }) : super(key: key, 
    backgroundColor: const Color.fromRGBO(17, 0, 104, 1),
      leading: const Icon(Icons.library_books_outlined),
      title: Text(titlePage),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => ListUserScreen()
              )
            );
          },
          icon: const Icon(Icons.list)
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => AddUserScreen()
              )
            );
          },
          icon: const Icon(Icons.list)
        ),
      ],
  );
}