import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:userlist/Album.dart';

class HTTPNetwork {
  static Future<Album> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
  
  static Future<List<Map<String, dynamic>>> getUsers() async {
    final response = await http
        .get(Uri.parse('https://ifri.raycash.net/getusers'));

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> output = [];
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<dynamic> data = jsonDecode(response.body)["message"];
      data.forEach((element) {
        output.add(element);
      });

      return output;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load users');
    }
  }
  
  static Future<List<Map<String, dynamic>>> getUser(String id) async {
    final response = await http
        .get(Uri.parse('https://ifri.raycash.net/getuser/'+id));

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> output = [];
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(response.body)["message"];
      
      output.add(data);
      return output;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load user');
    }
  }
  
  static Future<bool> addUser(var data) async {
    final response = await http
        .post(Uri.parse('https://ifri.raycash.net/adduser'), body: data);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  
  static Future<bool> updateUser(String id, var data) async {
    final response = await http
        .post(Uri.parse('https://ifri.raycash.net/updateuser/'+id), body: data);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}