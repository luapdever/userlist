import 'dart:io';

import 'package:flutter/material.dart';
import 'package:userlist/Https/network.dart';
import 'dart:convert';
import 'package:userlist/Models/Arguments/UserArguments.dart';
import 'package:userlist/Models/User.dart';
import 'package:userlist/components/appbar.dart';
import 'package:userlist/screens/home.dart';
import 'package:userlist/sql_db/sql_helper.dart';
import 'package:userlist/screens/AddUser.dart';
import 'package:userlist/screens/ListUserScreen.dart';
import 'package:userlist/screens/UserScreen.dart';
import 'package:userlist/screens/albums.dart';
import 'package:userlist/screens/members.dart';


class UpdateUserScreen extends StatelessWidget {
  const UpdateUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "UserList",
      onGenerateRoute: (settings) {
        final args = ModalRoute.of(context)!.settings.arguments as UserArguments;

        return MaterialPageRoute(
            builder: (context) {
              return MainScreen(idUser: args.id, fullName: args.fullName);
            },
        );
      },
      routes: {
        "home": (context) => HomeScreen(),
        "list_user": (context) => ListUserScreen(),
        "add_user": (context) => AddUserScreen(),
        "user": (context) => UserScreen(),
        "update_user": (context) => UpdateUserScreen(),
        "members":(context) => const MembersScreen(),
        "albums":(context) => AlbumsScreen()
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  late String idUser;
  late String fullName;

  MainScreen({Key? key, required this.idUser, required this.fullName }) : super(key: key);

  @override
  State<MainScreen> createState() => _UserState();
}

class _UserState extends State<MainScreen> {

  Map<String, dynamic> _user = {"id": null};
  bool isLoading = true;
  bool updating = false;
  final _formKey = GlobalKey<FormState>();

  String? firstName;

  String? name;

  DateTime? birthday;
  final birthdayController = TextEditingController();

  String? adress;

  String? phone;
  
  String? mail;
  final mailController = TextEditingController();

  String? gender;

  String? citation;

  String dateFormat(DateTime date) {
    if(date == null) {
      return "";
    }
    return date.year.toString() + "-" + date.month.toString().padLeft(2, "0") + "-" + date.day.toString().padLeft(2, "0");
  } 

  _showMsg(msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // Code to execute.
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // SQLHelper.getItem(widget.idUser).then((value) {
    //   setState(() {
    //     _user = value[0];
    //     isLoading = false;
    //   });
    // });

    HTTPNetwork.getUser(widget.idUser).then((value) {
      setState(() {
        _user = value[0];
        gender = _user["gender"];
        birthday = DateTime.parse("2000-01-01");
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: BaseAppBar(titlePage: widget.fullName, context: context),
      body: isLoading 
        ? Center( child: Column(mainAxisAlignment: MainAxisAlignment.center ,children: const[
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Loading, wait...")
          ]),
        )
        : (_user["id"] == null ? 
          const Center(
            child: Text("This user don't exist"),
          )
         : Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: SingleChildScrollView(
                  child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Informations ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Color.fromRGBO(17, 0, 104, 1)
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: TextEditingController(text: _user["firstname"]),
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                        prefixIcon: Icon(Icons.supervised_user_circle_outlined),
                      ),
                      validator: (firstNameValue) {
                        if (firstNameValue!.isEmpty) {
                          return 'This field is required';
                        }
                        firstName = firstNameValue;
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: TextEditingController(text: _user["lastname"]),
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                        prefixIcon: Icon(Icons.supervised_user_circle_outlined),
                      ),
                      validator: (nameValue) {
                        if (nameValue!.isEmpty) {
                          return 'This field is required';
                        }
                        name = nameValue;
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.none,
                      controller: TextEditingController(text: dateFormat(birthday!)),
                      decoration: const InputDecoration(
                        labelText: 'Birth Date',
                        prefixIcon: Icon(Icons.calendar_month_outlined),
                      ),
                      onTap: () async {
                        DateTime? dateTime = await showDatePicker(
                          context: context,
                          initialDate: DateTime.parse("2000-01-01"),
                          firstDate: DateTime.parse("1960-01-01"),
                          lastDate: DateTime.now()
                        );
                        
                        if(mounted && dateTime != null) {
                          setState(() {
                            birthday = dateTime;
                          });
                        }
                      },
                      validator: (birthdayValue) {
                        if (birthdayValue!.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // TextFormField(
                    //   keyboardType: TextInputType.emailAddress,
                    //   controller: mailController,
                    //   decoration: const InputDecoration(
                    //     labelText: 'Email Adress',
                    //     prefixIcon: Icon(Icons.email),
                    //   ),
                    //   validator: (emailValue) {
                    //     if (emailValue!.isEmpty) {
                    //       return 'This field is required';
                    //     }
                    //     mail = emailValue;
                    //     return null;
                    //   },
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.streetAddress,
                      controller: TextEditingController(text: _user["adress"]),
                      decoration: const InputDecoration(
                        labelText: 'Adress',
                        prefixIcon: Icon(Icons.location_city),
                      ),
                      validator: (adressValue) {
                        if (adressValue!.isEmpty) {
                          return 'This field is required';
                        }
                        adress = adressValue;
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: TextEditingController(text: _user["phone"]),
                      decoration: const InputDecoration(
                          labelText: 'Telephone Number',
                          prefixIcon: Icon(Icons.phone)),
                      validator: (phoneValue) {
                        if (phoneValue!.isEmpty) {
                          return 'This field is required';
                        }
                        phone = phoneValue;
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        Text("Gender")
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: "male",
                          groupValue: gender,
                          onChanged: (String? value) {
                            if(value != null) {
                              setState(() {
                                gender = value;
                              });
                            }
                          }
                        ),
                        const Text("Male"),
                        const SizedBox(width: 10),
                        Radio(
                          value: "female",
                          groupValue: gender,
                          onChanged: (String? value) {
                            if(value != null) {
                              setState(() {
                                gender = value;
                              });
                            }
                          }
                        ),
                        const Text("Female"),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: TextEditingController(text: _user["citation"]),
                      decoration: const InputDecoration(
                          hintText: 'Citation',
                      ),
                      validator: (citationValue) {
                        if (citationValue!.isEmpty) {
                          return 'This field is required';
                        }
                        citation = citationValue;
                        return null;
                      },
                      maxLines: 4,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          _saveUser();
                        },
                        color: Colors.blue,
                        child: updating
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )),
            ),
        )
      ),
    );
  }

  _saveUser() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        updating = true;
      });
      var data = {
        'firstname': firstName,
        'lastname': name,
        'phone': phone,
        'adress': adress,
        'gender': gender,
        'citation': citation,
        'birthday': dateFormat(birthday!),
      };

      HTTPNetwork.updateUser(widget.idUser, data).then((value) {
        if(value) {
          _showMsg("User updated successfully.");
          Navigator.of(context).pushReplacementNamed(
            "user",
            arguments: UserArguments(_user["id"], User.getFullName(_user))
          );
        } else {
          updating = false;
          _showMsg("User not updated.");
        }
      });

    } else {
      updating = false;
      _showMsg("Some field is missed.");
    }
  }
}