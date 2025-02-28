import 'package:sqflite/sqflite.dart';

import '../database.dart';


class SubjectController {
  late Database _db;
  final DatabaseConnection _databaseConnection = DatabaseConnection();

  Future<void> init() async {
    _db = await _databaseConnection.initDatabase();
  }

  // Create a new subject
  Future<int> addSubject(String subjectCode, String subjectName, String sem, double grade) async {
    return await _db.insert(
      'subject',
      {
        'subject_code': subjectCode,
        'subject_name': subjectName,
        'sem': sem,
        'grade': grade,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Read all subjects
  Future<List<Map<String, dynamic>>> getAllSubjects() async {
    return await _db.query('subject');
  }

  // Read a single subject by ID
  Future<Map<String, dynamic>?> getSubjectById(int id) async {
    List<Map<String, dynamic>> result = await _db.query(
      'subject',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Update a subject
  Future<int> updateSubject(int id, String subjectCode, String subjectName, String sem, double grade) async {
    return await _db.update(
      'subject',
      {
        'subject_code': subjectCode,
        'subject_name': subjectName,
        'sem': sem,
        'grade': grade,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete a subject
  Future<int> deleteSubject(int id) async {
    return await _db.delete(
      'subject',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
