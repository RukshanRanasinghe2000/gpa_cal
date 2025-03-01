import '../data/controllers/settings_controller.dart';
import '../data/controllers/subject_controller.dart';

class GPAService {
  /// Calculates the total credits of all subjects.
  ///
  /// Returns:
  /// - A `Future<int>` representing the total sum of credits.
  Future<int> getTotalCredits() async {
    int total = 0;
    SubjectController subjectController = SubjectController();
    List<String> creditList = await subjectController.getAllCredits();

    print("^^^^^^^^^^^^creditList");
    print(creditList);
    print("^^^^^^^^^^^^creditList");

    // Convert each credit from String to int and add to total
    for (String credit in creditList) {
      total += int.tryParse(credit) ?? 0;
    }

    return total;
  }

  /// Calculates the total grade points for all subjects.
  ///
  /// Returns:
  /// - A `Future<double>` representing the total grade points.
  Future<double> getTotalGradePoint() async {
    double totalGradePoint = 0.0;
    SubjectController subjectController = SubjectController();
    SettingController settingController = SettingController();

    List<Map<String, dynamic>> subjects = await subjectController.getAllSubjects();
    print("!!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
    print(subjects);
    print("!!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");


    for (var subject in subjects) {
      double? gpaValue = await settingController.getGpaValueByGrade(subject['grade'].toString());
      print("!!!********************");
      print(gpaValue);
      print("!!!********************");
      if (gpaValue != null) {
        totalGradePoint += int.parse(subject['credit'])* gpaValue.toDouble();
      }
    }

    return totalGradePoint;
  }

  /// Calculates the final GPA.
  ///
  /// Returns:
  /// - A `Future<double>` representing the final GPA.
  Future<String> getFinalGPA() async {
    double totalGradePoint = await getTotalGradePoint();
    int totalCredits = await getTotalCredits();
    print("#############################3");
    print(totalGradePoint);
    print("#############################3");
    return (totalGradePoint/totalCredits).toStringAsFixed(2);
  }
}
