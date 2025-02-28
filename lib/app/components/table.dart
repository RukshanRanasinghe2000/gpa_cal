import 'package:flutter/material.dart';
import 'package:gpa_cal/constant.dart';

import '../data/controllers/controllers.dart';

class TableWidget extends StatefulWidget {
  const TableWidget({super.key});

  @override
  _TableWidgetState createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  List<List<String>> rows = [];

  @override
  void initState() {
    super.initState();
    loadAll();
  }
  /// Loads all subjects from the database and populates the `rows` list for the table display.
  ///
  /// The method retrieves a list of subjects from the `SubjectController` using the `getAllSubjects`
  /// method, then processes each subject to extract the required fields: semester, subject code,
  /// subject name, and grade. Each of these fields is cast to a string, ensuring that the values
  /// are properly formatted for the table rows. If any field is missing or null, it is replaced
  /// with an empty string. The `rows` list is updated within the `setState` method to trigger a
  /// UI rebuild, reflecting the loaded data.
  void loadAll() async {
    SubjectController subjectController = SubjectController();
    List<Map<String, dynamic>> subjects = await subjectController.getAllSubjects();
    print(subjects);

    setState(() {
      rows = subjects.map((subject) {
        return [
          (subject['sem'] ?? '').toString(),
          (subject['subject_code'] ?? '').toString(),
          (subject['subject_name'] ?? '').toString(),
          (subject['grade'] ?? '').toString(),
        ];
      }).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Define responsive sizes based on screen dimensions
    double cellHeight = screenHeight * 0.07;
    double fontSize = screenWidth * 0.03;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1.8),
          3: FlexColumnWidth(1),
          4: FlexColumnWidth(0.5), // For edit button
        },
        border: const TableBorder.symmetric(),
        children: [
          _buildTableRow(
            ["Sem", "Code", "Module Name", "Grade", ""],
            isHeader: true,
            fontSize: fontSize,
            cellHeight: cellHeight,
          ),
          for (var row in rows)
            _buildTableRow(
              row,
              fontSize: fontSize,
              cellHeight: cellHeight,
              editButton: () =>
                  _editRow(context, row[0], row[1], row[2], row[3]),
            ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(List<String> data,
      {bool isHeader = false,
      required double fontSize,
      required double cellHeight,
      VoidCallback? editButton}) {
    return TableRow(
      decoration: isHeader
          ? const BoxDecoration(
              color: textTertiaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.43),
                topRight: Radius.circular(8.43),
              ),
            )
          : const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: textParagraph, width: 1.0),
                left: BorderSide(color: textParagraph, width: 1.0),
                right: BorderSide(color: textParagraph, width: 1.0),
              ),
            ),
      children: [
        for (int i = 0; i < data.length; i++)
          Container(
            height: cellHeight,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              data[i],
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                color: isHeader ? textTableHeader : textParagraph,
              ),
            ),
          ),
        if (!isHeader)
          Container(
            height: cellHeight,
            alignment: Alignment.center,
            child: IconButton(
              icon: const Icon(Icons.edit, color: textSecondaryColor),
              onPressed: editButton,
              style: const ButtonStyle(
                alignment: Alignment.centerLeft,
              ),
            ),
          ),
      ],
    );
  }

  void _editRow(BuildContext context, String sem, String code, String module,
      String grade) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: darkBackground,
        title: const Text('Edit Data',
            style: TextStyle(
              color: textSecondaryColor,
              fontFamily: primaryFont,
            )),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              style: const TextStyle(
                color: textParagraph,
                fontFamily: primaryFont,
              ),
              initialValue: sem,
              decoration: const InputDecoration(
                  labelText: 'Semester',
                  labelStyle: TextStyle(color: textParagraph)),
            ),
            TextFormField(
              style: const TextStyle(
                color: textParagraph,
                fontFamily: primaryFont,
              ),
              initialValue: code,
              decoration: const InputDecoration(
                  labelText: 'Code',
                  labelStyle: TextStyle(color: textParagraph)),
            ),
            TextFormField(
              style: const TextStyle(
                color: textParagraph,
                fontFamily: primaryFont,
              ),
              initialValue: module,
              decoration: const InputDecoration(
                  labelText: 'Module name',
                  labelStyle: TextStyle(color: textParagraph)),
            ),
            TextFormField(
              style: const TextStyle(
                color: textParagraph,
                fontFamily: primaryFont,
              ),
              initialValue: grade,
              decoration: const InputDecoration(
                  labelText: 'Grade',
                  labelStyle: TextStyle(color: textParagraph)),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all<Color>(textSecondaryColor),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: textTableHeader,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all<Color>(textSecondaryColor),
            ),
            child: const Text(
              'Save',
              style: TextStyle(
                color: textTableHeader,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
