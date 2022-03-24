import 'package:flutter/material.dart';


class BaseAppBar extends AppBar {
  
  final String titlePage;

  BaseAppBar({ Key? key, required this.titlePage, required BuildContext context }) : super(key: key, 
    backgroundColor: const Color.fromRGBO(17, 0, 104, 1),
      title: Row(
        children: [
          Image.asset(
            "icon.png",
            width: 40,
          ),
          const SizedBox(width: 10),
          Text(titlePage)
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed("list_user");
          },
          icon: const Icon(Icons.list)
        ),
      ],
  );
}