import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();
  bool isloading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  void createAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cPasswordController.text.trim();

    if (email == "" || password == "" || cPassword == "") {
      // log("Fill Full Details");
      print(ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please Fill The Full Details "),
        backgroundColor: Colors.red,
      )));
    } else if (password != cPassword) {
      print(ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password Not Match?"),
        backgroundColor: Colors.red,
      )));
    } else {
      try {
        setState(() {
          isloading = true;
        });
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create an account"),
      ),
      body: Form(
        key: _formkey,
        child: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Email is empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          label: Text("Enter Your Email Here"),
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(labelText: "Password"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: cPasswordController,
                      decoration:
                          InputDecoration(labelText: "Confirm Password"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // CupertinoButton(
                    //   onPressed: () {
                    //     // print(ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //     //   content: Text("Succesfull?"),
                    //     //   backgroundColor: Colors.green,
                    //     // )));
                    //     createAccount();
                    //   },
                    //   color: Colors.blue,
                    //   child: Text("Create Account"),
                    // )
                    ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            createAccount();
                          }
                        },style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                        child: isloading
                            ? Center(
                                child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                            : Text(
                                "Create Account",
                                style: TextStyle(color: Colors.black),
                              )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
