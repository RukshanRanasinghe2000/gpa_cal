import 'package:flutter/material.dart';
import 'package:gpa_cal/constant.dart';
import '../data/controllers/settings_controller.dart';
import '../data/controllers/subject_controller.dart';
import '../data/validators/form_validation.dart';

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
  SettingController settingController = SettingController();

  List<String> allGrades = [];
  String? selectedGrade;

  @override
  void initState() {
    super.initState();
    _loadGrades();
  }

  Future<void> _loadGrades() async {
    List grades = await settingController.getAllGrades();
    setState(() {
      allGrades = grades.map((row) => row['grade'] as String).toList();
    });
  }

  void clearForm() {
    _semesterController.clear();
    _moduleCodeController.clear();
    _nameController.clear();
    _gradeController.clear();
    _creditController.clear();
    setState(() {
      selectedGrade = null;
    });
  }

  Future<void> save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Check if the dropdown value is selected
    if (selectedGrade == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Grade is required')),
      );
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
      String grade = selectedGrade!;
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
            child: SingleChildScrollView(
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
                  _buildTextField("Semester", _semesterController,
                      validator: (value) => FormValidator.validateRequired(value, "Semester")),
                  _buildTextField("Module Code", _moduleCodeController,
                      validator: (value) => FormValidator.validateRequired(value, "Module Code")),
                  _buildTextField("Name", _nameController,
                      validator: (value) => FormValidator.validateRequired(value, "Name")),
                  _buildTextField("Credit", _creditController,
                      keyboardType: TextInputType.number,
                      validator: FormValidator.validateCredit),
                  if (allGrades.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: DropdownButton<String>(
                          value: selectedGrade,
                          items: allGrades.map((String grade) {
                            return DropdownMenuItem<String>(
                              value: grade,
                              child: Text(grade),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedGrade = newValue;
                            });
                          },
                          hint: const Text(
                            "Select a Grade",
                            style: TextStyle(
                              color: textParagraph,
                              fontFamily: primaryFont,
                            ),
                          ),
                          style: TextStyle(
                            color: textParagraph,
                            fontFamily: primaryFont,
                          ),
                          dropdownColor: darkBackground,
                        ),
                      ),
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
            )
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
        autofocus: true,
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
