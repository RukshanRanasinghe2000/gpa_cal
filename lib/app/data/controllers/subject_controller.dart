import 'package:sqflite/sqflite.dart';
import '../database.dart';

class SubjectController {
  // Create a new subject
  /// Adds a new subject to the database with the given details.
  ///
  /// Parameters:
  /// - [subjectCode]: The code of the subject (e.g., "CS101").
  /// - [subjectName]: The name of the subject (e.g., "Computer Science").
  /// - [sem]: The semester for the subject (e.g., "Spring 2025").
  /// - [grade]: The grade received for the subject (e.g., "A").
  /// - [credit]: The grade received for the subject (e.g., "7").
  ///
  /// Returns the id of the newly inserted subject.
  Future<int> addSubject(String subjectCode, String subjectName, String sem,
      String grade, String credit) async {
    late Database _db;
    final DatabaseConnection _databaseConnection = DatabaseConnection();
    _db = await _databaseConnection.initDatabase();
    return await _db.insert(
      'subject',
      {
        'subject_code': subjectCode,
        'subject_name': subjectName,
        'sem': sem,
        'grade': grade,
        'credit': credit,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Read all subjects
  /// Fetches all subjects stored in the database.
  ///
  /// Returns a list of maps, where each map contains the data of a subject.
  Future<List<Map<String, dynamic>>> getAllSubjects() async {
    late Database _db;
    final DatabaseConnection _databaseConnection = DatabaseConnection();
    _db = await _databaseConnection.initDatabase();
    return await _db.query('subject');
  }

  // Read a single subject by ID
  /// Fetches a single subject from the database based on the provided [id].
  ///
  /// Parameters:
  /// - [id]: The id of the subject to fetch.
  ///
  /// Returns a map containing the subject's data, or null if no subject was found with the given id.
  Future<Map<String, dynamic>?> getSubjectById(int id) async {
    late Database _db;
    final DatabaseConnection _databaseConnection = DatabaseConnection();
    _db = await _databaseConnection.initDatabase();
    List<Map<String, dynamic>> result = await _db.query(
      'subject',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Update a subject
  /// Updates the details of a subject in the database based on the provided [id].
  ///
  /// Parameters:
  /// - [id]: The id of the subject to update.
  /// - [subjectCode]: The updated subject code.
  /// - [subjectName]: The updated subject name.
  /// - [sem]: The updated semester.
  /// - [grade]: The updated grade.
  ///
  /// Returns the number of affected rows.
  Future<int> updateSubject(int id, String subjectCode, String subjectName,
      String sem, String grade, String credit) async {
    late Database _db;
    final DatabaseConnection _databaseConnection = DatabaseConnection();
    _db = await _databaseConnection.initDatabase();
    return await _db.update(
      'subject',
      {
        'subject_code': subjectCode,
        'subject_name': subjectName,
        'sem': sem,
        'grade': grade,
        'credit': credit,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete a subject
  /// Deletes a subject from the database based on the provided [id].
  ///
  /// Parameters:
  /// - [id]: The id of the subject to delete.
  ///
  /// Returns the number of rows affected (should be 1 if successful, 0 if no subject was found with the given id).
  Future<int> deleteSubject(int id) async {
    late Database _db;
    final DatabaseConnection _databaseConnection = DatabaseConnection();
    _db = await _databaseConnection.initDatabase();
    return await _db.delete(
      'subject',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}