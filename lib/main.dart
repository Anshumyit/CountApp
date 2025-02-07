import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/view/LoginPages.dart';
import 'package:untitled/view/couunt.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? username = prefs.getString('username');

  runApp(MyApp(startScreen: username == null ? LoginScreen() : CounterScreen(username: username)));
}

class MyApp extends StatelessWidget {
  final Widget startScreen;
  MyApp({required this.startScreen});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: startScreen,
    );
  }
}
