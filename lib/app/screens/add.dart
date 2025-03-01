import 'package:flutter/material.dart';
import 'package:gpa_cal/constant.dart';
import '../data/controllers/subject_controller.dart';

class AddInfo extends StatefulWidget {
  const AddInfo({super.key});

  @override
  _AddInfoState createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _semesterController = TextEditingController();
  final TextEditingController _moduleCodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _creditController = TextEditingController();

  void clearForm() {
    _semesterController.clear();
    _moduleCodeController.clear();
    _nameController.clear();
    _gradeController.clear();
    _creditController.clear();
  }

  Future<void> save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    bool? confirmSave = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: darkBackground,
          title: const Text(
            "Confirm Save",
            style: TextStyle(
              color: textSecondaryColor,
              fontFamily: primaryFont,
            ),
          ),
          content: const Text(
            "Are you sure you want to save this data?",
            style: TextStyle(
              color: textParagraph,
              fontFamily: primaryFont,
            ),
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(textSecondaryColor),
              ),
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: textTableHeader,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(textSecondaryColor),
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                "Save",
                style: TextStyle(
                  color: textTableHeader,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmSave == true) {
      String semester = _semesterController.text.trim();
      String moduleCode = _moduleCodeController.text.trim();
      String name = _nameController.text.trim();
      String grade = _gradeController.text.trim().toUpperCase();
      String credit = _creditController.text.trim();

      SubjectController().addSubject(moduleCode, name, semester, grade, credit);

      clearForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: darkBackground,
      body: SafeArea(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: const BoxDecoration(
            gradient: backgroundGradient,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.10,
                    right: screenWidth * 0.10,
                    top: screenHeight * 0.07,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Add Grades",
                      style: TextStyle(
                        fontFamily: primaryFont,
                        fontSize: screenWidth * 0.1,
                        fontWeight: FontWeight.w600,
                        color: textSecondaryColor,
                      ),
                    ),
                  ),
                ),
                _buildTextField("Semester", _semesterController),
                _buildTextField("Module Code", _moduleCodeController),
                _buildTextField("Name", _nameController),
                _buildTextField(
                  "Grade",
                  _gradeController,
                  validator: (value) {
                    if (value!.isEmpty) return "Grade is required";
                    if (!RegExp(r"^(A\+|A-|A|B\+|B-|B|C\+|C-|C|D\+|D-|D|E)$", caseSensitive: false).hasMatch(value)) {
                      return "Enter a valid grade (A+, A, A-, B+, B, ...)";
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  "Credit",
                  _creditController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) return "Credit is required";
                    if (!RegExp(r"^\d+(\.\d+)?$").hasMatch(value)) {
                      return "Enter a valid number";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.10,
                    right: screenWidth * 0.10,
                    top: screenHeight * 0.07,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: save,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(textSecondaryColor),
                      ),
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: textTableHeader,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label,
      TextEditingController controller, {
        TextInputType keyboardType = TextInputType.text,
        String? Function(String?)? validator,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator ??
                (value) {
              if (value!.isEmpty) {
                return "$label is required";
              }
              return null;
            },
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: label,
          labelStyle: const TextStyle(color: textParagraph),
        ),
        style: const TextStyle(
          color: textParagraph,
          fontFamily: primaryFont,
        ),
      ),
    );
  }
}
