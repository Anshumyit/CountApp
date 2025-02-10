import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/database/data.dart';


// Current logged-in user provider
final userProvider = StateProvider<String?>((ref) => null);

// Counter state provider
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  final username = ref.watch(userProvider);
  return CounterNotifier(username);
});

class CounterNotifier extends StateNotifier<int> {
  String? username;
  CounterNotifier(this.username) : super(0) {
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    if (username != null) {
      int savedCounter = await DatabaseHelper().getUserCounter(username!);
      state = savedCounter;
    }
  }

  Future<void> incrementCounter() async {
    if (username != null) {
      state++;
      await DatabaseHelper().updateCounter(username!, state);
    }
  }

  Future<void> resetUser() async {
    state = 0;
  }
}

// All users provider
final usersProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  return await DatabaseHelper().getAllUsers();
});
