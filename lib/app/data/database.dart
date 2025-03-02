import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'controllers/subject_controller.dart';

class DatabaseConnection {

  /// Checks if the database exists at the given [path].
  Future<bool> databaseExists(String path) =>
      databaseFactory.databaseExists(path);

  /// Initializes and returns the database connection.
  ///
  /// - On **desktop platforms** (Windows, macOS, Linux), it initializes `sqflite_common_ffi` for database operations.
  /// - If the database does **not exist**, it creates a new database and calls [_createDatabase] to set up the tables.
  /// - If the database **already exists**, it simply opens the existing database.
  ///
  /// Returns a [Future] that completes with the initialized [Database] instance.
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

  /// Creates the necessary tables in the database.
  ///
  /// This function is called automatically when a new database is created.
  ///
  /// - **subject** table stores information about subjects.
  /// - **settings** table stores GPA-related settings.
  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE subject (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        subject_code TEXT NOT NULL,
        subject_name TEXT NOT NULL,
        sem TEXT NOT NULL,
        credit TEXT,
        grade TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE settings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        grade TEXT NOT NULL,
        gpa_value REAL NOT NULL
      )
    ''');
  }
}
