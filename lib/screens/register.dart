import '/screens/home.dart';
import '/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:userlist/Https/request.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var name;
  var email;
  var telephone;
  var password;
  var passwordConfirm;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UserList"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Inscription ',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 60.0,
                      color: Colors.blue),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nom & Prenom',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.supervised_user_circle_outlined),
                  ),
                  validator: (nameValue) {
                    if (nameValue!.isEmpty) {
                      return 'Votre nom est obligatoire';
                    }
                    name = nameValue;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Address mail',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (emailValue) {
                    if (emailValue!.isEmpty) {
                      return 'Votre mail est obligatoire';
                    }
                    email = emailValue;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: telephoneController,
                  decoration: const InputDecoration(
                      labelText: 'Numero Téléphone',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone)),
                  validator: (telephoneValue) {
                    if (telephoneValue!.isEmpty) {
                      return 'Le numero de téléphon est obligatoire';
                    }
                    telephone = telephoneValue;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Mot de passe',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.remove_red_eye),
                  ),
                  validator: (passwordValue) {
                    if (passwordValue!.isEmpty) {
                      return 'Entrer votre mot de passe';
                    }
                    password = passwordValue;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordConfirmController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirme mot de passe',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.remove_red_eye),
                  ),
                  validator: (passwordConfirmValue) {
                    if (passwordConfirmValue!.isEmpty &&
                        password != passwordConfirmValue) {
                      return "Le mot de passe n'est pas conforme";
                    }
                    passwordConfirm = passwordConfirmValue;
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        //
                      },
                      child: Text(
                        'Mot de passe oublié ?',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.4),
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ],
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
                      _register();
                    },
                    color: Colors.blue,
                    child: const Text(
                      "S'INSCRIRE",
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
                const Divider(
                  color: Colors.black,
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '''Aviez vous un compte ? ''',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 16.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: const Text("Se Connecter"),
                    )
                  ],
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      var data = {
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirm,
        'telephone': telephone,
        'name': name,
      };
      var response = await HttpNetwork().authData(data, 'auth/register');
      var body = jsonDecode(response.body);
      if(body["error"]){
        _showMsg("Problème lors de l'inscription");
      }else{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    }
  }
}
