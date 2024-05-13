import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:new_project/Screens/Api.dart';
// import 'package:new_project/Screens/Api.dart';
// import 'package:new_project/Screens/Splash.dart';
// import 'package:new_project/Screens/Splash.dart';
import 'package:new_project/firebase_options.dart';
  late Size mq;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'New Project',
        debugShowCheckedModeBanner: false,
        home: Apicall());
  }
}
