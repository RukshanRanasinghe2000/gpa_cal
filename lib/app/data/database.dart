import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseConnection {

  Future<bool> databaseExists(String path) =>
      databaseFactory.databaseExists(path);

  Future<Database> initDatabase() async {
    try {
      // Initialize databaseFactory for desktop platforms
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        databaseFactory = databaseFactoryFfi;
      }

      final databasePath = await getDatabasesPath();
      final databaseName = 'gpa_app_db.db';
      final dbPath = join(databasePath, databaseName);

      var dbStatus = await databaseExists(dbPath);

      if (!dbStatus) {
        print('Database does not exist. Creating database...');
        return openDatabase(
          dbPath,
          version: 1,
          onCreate: _createDatabase,
        );
      } else {
        print('Database already exists. Opening database...');
        return openDatabase(dbPath);
      }
    } catch (e) {
      throw Exception("Error initializing database: $e");
    }
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE subject (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        subject_code TEXT NOT NULL,
        subject_name TEXT NOT NULL,
        sem TEXT NOT NULL,
        grade TEXT NOT NULL
      )
    ''');
  }
}
