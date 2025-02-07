import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/view/LoginPages.dart';

import '../database/data.dart';


class CounterScreen extends StatefulWidget {
  final String username;
  CounterScreen({required this.username});

  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int counter = 0;
  List<Map<String, dynamic>> allUsers = [];

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    int savedCounter = await DatabaseHelper().getUserCounter(widget.username);
    List<Map<String, dynamic>> users = await DatabaseHelper().getAllUsers();
    setState(() {
      counter = savedCounter;
      allUsers = users;
    });
  }

  Future<void> _incrementCounter() async {
    setState(() {
      counter++;
    });
    await DatabaseHelper().updateCounter(widget.username, counter); // Save to DB
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username'); // Remove username from storage
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen())); // Redirect to login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter - ${widget.username}"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome, ${widget.username}", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Text("Counter: $counter", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: Text("Increment"),
            ),
            SizedBox(height: 20),
            Text("All Users' Data:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...allUsers.map((user) => Text("${user['username']} - ${user['counter']}")).toList(),
          ],
        ),
      ),
    );
  }
}
