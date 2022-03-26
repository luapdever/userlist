import 'package:flutter/material.dart';
import 'package:userlist/Models/User.dart';
import 'package:userlist/components/SearchDelegate.dart';


class BaseAppBar extends AppBar {
  
  final String titlePage;

  static String smallTitle(String title) {
    return title.substring(0, title.length > 15 ? 15 : title.length)
          + (title.length > 15 ? "..." : "");
  }

  BaseAppBar({ Key? key, required this.titlePage, required BuildContext context }) : super(key: key, 
    backgroundColor: const Color.fromRGBO(17, 0, 104, 1),
      title: Wrap(
        children: [
          Text(smallTitle(titlePage))
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            showSearch(context: context, delegate: MySearchDelegate());
          },
          icon: const Icon(Icons.search)
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed("list_user");
          },
          icon: const Icon(Icons.list)
        ),
        PopupMenuButton(itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("members");
              },
              child: const Text(
                "Group members",
                style: TextStyle(color: Colors.black),
              )
            ))
          ];
        })
      ],
  );
}