import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'counter_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE users (id INTEGER PRIMARY KEY, username TEXT UNIQUE, counter INTEGER)',
        );
      },
    );
  }

  Future<void> insertUser(String username) async {
    final db = await database;
    await db.insert(
      'users',
      {'username': username, 'counter': 0},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<int> getUserCounter(String username) async {
    final db = await database;
    var result = await db.query('users', where: 'username = ?', whereArgs: [username]);
    if (result.isNotEmpty) {
      return result.first['counter'] as int;
    }
    return 0;
  }

  Future<void> updateCounter(String username, int newCounter) async {
    final db = await database;
    await db.update(
      'users',
      {'counter': newCounter},
      where: 'username = ?',
      whereArgs: [username],
    );
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.query('users');
  }
}
