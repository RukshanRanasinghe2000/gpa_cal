class DataValidation {
  // Validate if the field is empty
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  // Validate Grade (Only A-F accepted)
  static String? validateGrade(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Grade is required";
    }
    if (!RegExp(r"^[A-Fa-f]$" ).hasMatch(value.trim())) {
      return "Enter a valid grade (A-F)";
    }
    return null;
  }

  // Validate Credit (Only numeric values allowed)
  static String? validateCredit(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Credit is required";
    }
    if (!RegExp(r"^\d+(\.\d+)?$").hasMatch(value.trim())) {
      return "Enter a valid number";
    }
    return null;
  }
}