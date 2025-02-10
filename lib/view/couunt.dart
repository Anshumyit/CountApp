import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Ensure Riverpod is imported
import 'package:untitled/view/LoginPages.dart';
import 'package:untitled/viewmodel/riverpod.dart';

class CounterScreen extends ConsumerWidget {
  final String username;
  CounterScreen({required this.username});

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');

    ref.invalidate(userProvider); // Resets the user state properly

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final counterNotifier = ref.read(counterProvider.notifier);
    final allUsers = ref.watch(usersProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Counter - $username"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context, ref),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome, $username", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Text("Counter: $counter", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => counterNotifier.incrementCounter(), // Ensure correct method call
              child: Text("Increment"),
            ),
            SizedBox(height: 20),
            Text("All Users' Data:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            allUsers.when(
              data: (users) => Column(
                children: users.map((user) => Text("${user['username']} - ${user['counter']}")).toList(),
              ),
              loading: () => CircularProgressIndicator(),
              error: (e, stack) => Text("Error loading users"),
            ),
          ],
        ),
      ),
    );
  }
}
