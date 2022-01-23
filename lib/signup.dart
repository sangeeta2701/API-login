// import 'package:api_signin_screen_2/signin.dart';
import 'dart:convert';

import 'package:api_signin_screen_2/services/api_client.dart';
import 'package:api_signin_screen_2/signin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var countryController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmpassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.lightBlueAccent, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Center(
          child: Container(
            height: 450,
            width: 350,
            child: ListView(children: [
              Center(
                child: Text(
                  "Sign-Up Here",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(FontAwesomeIcons.user)),
              ),
              SizedBox(
                height: 5,
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
                controller: phoneController,
                decoration: InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(FontAwesomeIcons.phone)),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(FontAwesomeIcons.city)),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: stateController,
                decoration: InputDecoration(
                    labelText: 'State',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(FontAwesomeIcons.mapMarkerAlt)),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: countryController,
                decoration: InputDecoration(
                    labelText: 'Country',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(FontAwesomeIcons.globeAsia)),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(FontAwesomeIcons.eyeSlash)),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: confirmpassController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm password',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(FontAwesomeIcons.eyeSlash),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              OutlineButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                  final snackBar = SnackBar(
                    content: const Text('User signup successful'),
                    action: SnackBarAction(
                      label: 'Move Further',
                      onPressed: () {
                        // Some code to undo the change.
                      },
                    ),
                  );

                  // Find the ScaffoldMessenger in the widget tree
                  // and use it to show a SnackBar.
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  // signup();
                },
                icon: Icon(
                  FontAwesomeIcons.signInAlt,
                  size: 22,
                ),
                label: Text(
                  "Sign Up",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> signup() async {
    Map<String, dynamic> body = {
      'name': "ABCD",
      'email': "working@gmail.com",
      'phone': '999954312',
      'city': "Mumbai",
      'state': "Maharashtra",
      'country': "India",
      "password": "pass123",
      "cpassword": "pass123"
    };
    String value = json.encode(body);
    try {
      var response = await ApiClient.getServices().requestSignUp(value);
      if (nameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          cityController.text.isNotEmpty &&
          stateController.text.isNotEmpty &&
          countryController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          confirmpassController.text.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('User Signup Successful'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please fill all data correctly")));
      }
    } catch (e) {
      var error = e as DioError;
      if (error.response!.statusCode == 422) {
        print(error.response!.data);
      }

      print(error);
      print(e);
    }
  }
}
