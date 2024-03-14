// import 'dart:developer';
// import 'dart:math';
import 'package:firebase/Home.dart';
import 'package:firebase/Screens/Email_Auth/Signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:velocity_x/velocity_x.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  void login() async {
    String email = _email.text.trim();
    String password = _password.text.trim();

    if (email == "" || password == "") {
      print(ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please Fill The Details"),
        backgroundColor: Colors.red,
      )));
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
              context, CupertinoPageRoute(builder: (context) => Home_Page()));
        }
      } on FirebaseAuthException catch (ex) {
        if (ex.code.toString == ex.code.toString) {
          print(ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Something Wrong"),
            backgroundColor: Colors.red,
          )));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Form(
        key: _formkey,
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 20)),
                TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      label: Text("Enter your Email Here")),
                ),
                20.heightBox,
                TextFormField(
                  controller: _password,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      label: Text("Enter your Password Here")),
                ),
                20.heightBox,
                ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    child: Text("Login")),
                10.heightBox,
                TextButton(
                    onPressed: () {
                      Get.to(SignUpScreen());
                    },
                    child: Text(
                      "Create An Account ?",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
