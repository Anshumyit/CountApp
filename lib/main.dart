import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/database/data.dart';
import 'package:untitled/view/LoginPages.dart';
import 'package:untitled/view/couunt.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? username = prefs.getString('username');

  if (username != null) {
    await DatabaseHelper().insertUser(username);
    int currentCounter = await DatabaseHelper().getUserCounter(username);
    await DatabaseHelper().updateCounter(username, currentCounter + 1);
  }

  runApp(ProviderScope(
    child: MyApp(startScreen: username == null ? LoginScreen() : CounterScreen(username: username)),
  ));
}

class MyApp extends StatelessWidget {
  final Widget startScreen;
  MyApp({required this.startScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counter App with Riverpod',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: startScreen,
    );
  }
}
