
import 'package:userlist/sql_db/sql_helper.dart';

class User {
  List<Map<String, dynamic>> users = [];

  static String getFullName(var user) {
    return user["firstName"] + " " + user["name"];
  }

  User() {
    SQLHelper.getItems().then((value) {
      users = value;
    });
  }
}