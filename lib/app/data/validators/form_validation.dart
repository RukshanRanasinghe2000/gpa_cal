class FormValidator {
  /// Validates if a required field is empty.
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  /// Validates if the entered grade is valid.
  static String? validateGrade(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Grade is required";
    }
    if (!RegExp(r"^(A\+|A-|A|A|B\+|B-|B|C\+|C-|C|D\+|D-|D|E)$", caseSensitive: false).hasMatch(value)) {
      return "Enter a valid grade (A+, A, A-, B+, B, ...)";
    }
    return null;
  }

  /// Validates if the entered credit is a valid number.
  static String? validateCredit(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Credit is required";
    }
    if (!RegExp(r"^\d+(\.\d+)?$").hasMatch(value)) {
      return "Enter a valid number";
    }
    return null;
  }
}