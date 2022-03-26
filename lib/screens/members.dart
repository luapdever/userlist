import 'package:flutter/material.dart';
import 'package:userlist/components/appbar.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titlePage: "Members", context: context),
      body: Container(
        padding: const EdgeInsets.only(
          top: 16.0
        ),
        child: Column(
          children: [
            Title(
              color: const Color.fromRGBO(17, 0, 104, 1),
              child: const Text(
                "Group Members",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
              )
            ),
            Card(
              child: GestureDetector(
                child: const ListTile(
                  leading: Icon(Icons.person_rounded),
                  title: Text("ABDOULAYE Nadjath"),
                  subtitle: Text("+229 61 20 54 50"),
                ),
              )
            ),
            Card(
              child: GestureDetector(
                child: const ListTile(
                  leading: Icon(Icons.person_rounded),
                  title: Text("ADJABONI Carel"),
                  subtitle: Text("+229 65 93 84 89"),
                ),
              )
            ),
            Card(
              child: GestureDetector(
                child: const ListTile(
                  leading: Icon(Icons.person_rounded),
                  title: Text("SANNY Khaled"),
                  subtitle: Text("+229 61 64 02 92"),
                ),
              )
            ),
            Card(
              child: GestureDetector(
                child: const ListTile(
                  leading: Icon(Icons.person_rounded),
                  title: Text("ZANNOU Paul"),
                  subtitle: Text("+229 90 66 73 33"),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}