import 'package:sqflite/sqflite.dart';

import '../database.dart';

class SettingController {
  // Create a new setting
  Future<int> addSetting(String grade, double gpaValue) async {
    late Database _db;
    final DatabaseConnection _databaseConnection = DatabaseConnection();
    _db = await _databaseConnection.initDatabase();
    return await _db.insert(
      'settings',
      {
        'grade': grade,
        'gpa_value': gpaValue,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Update a setting
  Future<int> updateSetting(int id, String grade, double gpaValue) async {
    late Database _db;
    final DatabaseConnection _databaseConnection = DatabaseConnection();
    _db = await _databaseConnection.initDatabase();
    return await _db.update(
      'settings',
      {
        'grade': grade,
        'gpa_value': gpaValue,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Read all settings
  /// Fetches all settings stored in the database.
  ///
  /// Returns a list of maps, where each map contains the data of a subject.
  Future<List<Map<String, dynamic>>> getAllSubjects() async {
    final DatabaseConnection _databaseConnection = DatabaseConnection();
    final Database _db = await _databaseConnection.initDatabase();

    // Check if the settings table is empty
    List<Map<String, dynamic>> settings = await _db.query('settings');

    if (settings.isEmpty) {
      // Insert default settings only if the table is empty
      SettingController subjectController = SettingController();
      await subjectController.insertDefaultSettings();

      // Re-fetch the settings after inserting default values
      settings = await _db.query('settings');
    }
    return settings;
  }

  // Check if there are no settings and insert default values
  Future<void> insertDefaultSettings() async {
    late Database _db;
    final DatabaseConnection _databaseConnection = DatabaseConnection();
    _db = await _databaseConnection.initDatabase();

    // Check if settings table is empty
    List<Map<String, dynamic>> settings = await _db.query('settings');

    if (settings.isEmpty) {
      // Default data
      List<List<dynamic>> rows = [
        ["A+", 4.0],
        ["A", 4.0],
        ["A-", 3.7],
        ["B+", 3.3],
        ["B", 3.0],
        ["B-", 2.7],
        ["C+", 2.3],
        ["C", 2.0],
        ["C-", 1.7],
        ["D+", 1.3],
        ["D", 1.0],
        ["E", 0.7],
        ["E", 0.0],
      ];

      // Insert default values into the table
      for (var row in rows) {
        await _db.insert(
          'settings',
          {
            'grade': row[0],
            'gpa_value': row[1],
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }
  }
}
