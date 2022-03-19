import 'package:flutter/material.dart';
import 'dart:convert';
import "package:userlist/Https/request.dart";
import 'package:userlist/components/appbar.dart';

class AddUserScreen extends StatefulWidget {
  AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}


// "id" : 1,
// "first_name" : "Luap",
// "name" : "Dever",
// "birthday" : DateTime.now(),
// "adress" : "Ad058 Est",
// "phone" : "22951486388",
// "mail" : "example@gmail.com",
// "gender" : "masculin",
// "picture" : "http://localhost:8000/img/test.jpg",
// "citation" : "Take more courage for flying high"

class _AddUserScreenState extends State<AddUserScreen> {

  String? _first_name;
  final _firstNameController = TextEditingController();

  String? _name;
  final _nameController = TextEditingController();

  DateTime? _birthday;
  final _birthdayController = TextEditingController();

  String? _adress;
  final _adressController = TextEditingController();

  String? _phone;
  final _phoneController = TextEditingController();
  
  String? _mail;
  final _mailController = TextEditingController();

  String? _gender;
  final _genderController = TextEditingController();

  String? _citation;
  final _citationController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titlePage: "Register", context: context),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(""),
              SizedBox(height: 15.0),

            ],
          ),
        ),
      ),
    );
  }
}