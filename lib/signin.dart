import 'dart:convert';

import 'package:api_signin_screen_2/services/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.lightBlueAccent, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
          child: Center(
            child: Container(
              height: 400,
              width: 300,
              child: Column(
                children: [
                  Text(
                    " Sign-In Here",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: 'E-mail',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.email)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(FontAwesomeIcons.eyeSlash)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  OutlineButton.icon(
                    onPressed: () {
                      signIn();
                    },
                    icon: Icon(FontAwesomeIcons.signInAlt),
                    label: Text(
                      "Sign In",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    var body = {"email": "working@gmail.com", "password": "pass123"};
    String value = json.encode(body);

    try {
      var response = await ApiClient.getServices().requestLogIn(value);
      if (emailController.text.isNotEmpty == "working@gmail.com" &&
          passwordController.text.isNotEmpty == "pass123") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("user Login successful"),
        ));
      }
      if (emailController.text.isEmpty && passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Please fill the data")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("user Login unsuccessful")));
      }

      // var response = await Dio().post(
      //     "https://signin-signup-userregistration.herokuapp.com/login",
      //     // options: Options(headers: {
      //     //   "Content-Type": "application/json",
      //     // }),
      //     data: jsonEncode({"email": "test@gmail.com", "password": "pass123"}));

    } catch (e) {
      print(e);
    }
  }
}
