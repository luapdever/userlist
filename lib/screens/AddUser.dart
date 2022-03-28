import 'dart:io';

import 'package:flutter/material.dart';
import 'package:userlist/components/appbar.dart';
import 'package:userlist/sql_db/sql_helper.dart';
import 'package:image_picker/image_picker.dart';

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
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  String? firstName;
  final firstNameController = TextEditingController();

  String? name;
  final nameController = TextEditingController();

  DateTime? birthday;
  final birthdayController = TextEditingController();

  String? adress;
  final adressController = TextEditingController();

  String? phone;
  final phoneController = TextEditingController();
  
  String? mail;
  final mailController = TextEditingController();

  String? gender;
  final genderController = TextEditingController();

  String? citation;
  final citationController = TextEditingController();

  String? picture;
  File? imageFile;

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


  /// Get from gallery
  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        picture = pickedFile.path;
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        picture = pickedFile.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      birthday = DateTime.parse("2000-01-01");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titlePage: "Register", context: context),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Your informations ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Color.fromRGBO(17, 0, 104, 1)
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Card(
                  child: imageFile == null
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          SizedBox(width: 10),
                          Text("Picture")
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              _getFromCamera();
                            },
                            icon: const Icon(Icons.camera_alt)
                          ),
                          IconButton(
                            onPressed: () {
                              _getFromGallery();
                            },
                            icon: const Icon(Icons.image)
                          )
                        ],
                      )
                    ]
                  )
                  : Container(
                    height: 200,
                    child: Image.file(
                      imageFile!,
                      fit: BoxFit.cover,
                    ),
                  )
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: firstNameController,
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
                  controller: nameController,
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
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: mailController,
                  decoration: const InputDecoration(
                    labelText: 'Email Adress',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (emailValue) {
                    if (emailValue!.isEmpty) {
                      return 'This field is required';
                    }
                    mail = emailValue;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  controller: adressController,
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
                  controller: phoneController,
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
                  controller: citationController,
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
                    child: isLoading
                    ? const CircularProgressIndicator()
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
      ),
    );
  }

  _saveUser() {
    if (_formKey.currentState!.validate()) {
      isLoading = true;
      var data = {
        'mail': mail,
        'firstName': firstName,
        'name': name,
        'phone': phone,
        'adress': adress,
        'gender': gender,
        'citation': citation,
        'birthday': dateFormat(birthday!),
        "picture": picture
      };

      SQLHelper.createItem(data).then((value) {
        if(value != 0) {
          _showMsg("User registred successfully.");
          Navigator.of(context).pushReplacementNamed("list_user");
        } else {
          _showMsg("User not registred.");
        }
      });
    } else {
      isLoading = false;
      _showMsg("Some field is missed.");
    }
  }
}