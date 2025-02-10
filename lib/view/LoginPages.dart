import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/database/data.dart';
import 'package:untitled/view/couunt.dart';
import 'package:untitled/viewmodel/riverpod.dart';


class LoginScreen extends ConsumerWidget {
  final TextEditingController _usernameController = TextEditingController();

  Future<void> _login(BuildContext context, WidgetRef ref) async {
    String username = _usernameController.text.trim();
    if (username.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);

      await DatabaseHelper().insertUser(username);
      ref.read(userProvider.notifier).state = username;
      ref.read(counterProvider.notifier).resetUser();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CounterScreen(username: username)),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "Enter Username"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _login(context, ref),
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
