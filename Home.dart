import 'dart:convert';
import 'package:firebase/Screens/Email_Auth/Login.dart';
import 'package:firebase/models/modelss.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  List<Product> _product = [];
  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  Future<void> fetchdata() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      final Productjson = jsonDecode(response.body);

      setState(() {
        _product = List<Product>.from(
            Productjson.map((Productjson) => Product.fromjson(Productjson)));
      });
    } else {
      throw Exception("faild to load");
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => Login_Screen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  logout();
                },
                icon: Icon(Icons.exit_to_app))
          ],
          title: Text("Home"),
        ),
        body: Container(
          // width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              itemCount: _product.length,
              itemBuilder: (context, index) {
                final photo = _product[index];
                return ListTile(
                  leading: Image.network(photo.image),
                  title: Text(photo.title),
                );
              }),
        ));
  }
}
