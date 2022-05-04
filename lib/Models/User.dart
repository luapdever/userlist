import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:userlist/sql_db/sql_helper.dart';

class User {
  List<Map<String, dynamic>> users = [];

  static String getFullName(var user) {
    return user["firstname"] + " " + user["lastname"];
  }
  
  static Widget Picture(String path) {
    if(path == "" || path == null) {
      return Image.network(
        "https://cdn.pixabay.com/photo/2016/04/01/10/11/avatar-1299805_960_720.png",
        height: 200,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(path),
        height: 200,
        fit: BoxFit.cover,
        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
            height: 200,
            fit: BoxFit.cover,
          );
        },
      );
    }
  }
  
  static ImageProvider<Object> Leading(String path) {
    if(path == "" || path == null) {
      return const NetworkImage(
        "https://cdn.pixabay.com/photo/2016/04/01/10/11/avatar-1299805_960_720.png",
      );
    } else {
      FileImage image;
      try {
        image = FileImage(
          File(path)
        );

      } on FileSystemException catch (e) {
        return const NetworkImage(
          "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
        );
      }

      return image;
    }
  }

  User() {
    SQLHelper.getItems().then((value) {
      users = value;
    });
  }
}