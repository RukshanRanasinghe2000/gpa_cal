import 'package:sqflite/sqflite.dart';

import '../database.dart';

class SettingController {

  /// Inserts a new setting into the `settings` table.
  ///
  /// This function adds a new grade and its corresponding GPA value to the database.
  /// If a setting with the same grade already exists, it will be replaced.
  ///
  /// - **Parameters:**
  ///   - `grade`: The grade (e.g., "A", "B", etc.).
  ///   - `gpaValue`: The GPA value corresponding to the grade.
  ///
  /// - **Returns:** A `Future<int>` that resolves to the ID of the inserted row.
  ///
  /// - **Database Table:** `settings`
  ///
  /// - **Conflict Handling:** If a duplicate entry exists, it will be replaced.
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

  /// Fetches the GPA value for a given grade.
  ///
  /// This function queries the database for a specific grade and returns its corresponding GPA value.
  ///
  /// Parameters:
  /// - [grade]: The grade (e.g., "A+", "B") to look up.
  ///
  /// Returns:
  /// - A `Future<double?>` representing the GPA value associated with the given grade.
  ///   If the grade is not found, `null` is returned.
  Future<double?> getGpaValueByGrade(String grade) async {

    final DatabaseConnection _databaseConnection = DatabaseConnection();
    final Database _db = await _databaseConnection.initDatabase();

    // Query the database for the given grade
    List<Map<String, dynamic>> result = await _db.query(
      'settings',
      columns: ['gpa_value'],
      where: 'grade = ?',
      whereArgs: [grade],
    );
    // Return GPA value if found, otherwise return null
    return result.isNotEmpty ? result.first['gpa_value'] as double : null;
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
