import 'package:flutter/material.dart';
import 'package:gpa_cal/constant.dart';

import '../data/controllers/settings_controller.dart';
import '../data/controllers/subject_controller.dart';

class SettingsTable extends StatefulWidget {
  final Function(bool)? onTableUpdated;
  const SettingsTable({super.key, this.onTableUpdated});

  @override
  _SettingsTableState createState() => _SettingsTableState();
}

class _SettingsTableState extends State<SettingsTable> {
  // This will hold the rows dynamically fetched from the database
  List<List<String>> rows = [];

  @override
  void initState() {
    super.initState();
    loadAll();
  }

  // This is a simulated method that mimics fetching data from a database
  Future<void> loadAll() async {
    SettingController settingController = SettingController();
    List<Map<String, dynamic>> settings = await settingController.getAllSubjects();
    // Simulating a delay (e.g., from an API or database)
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      rows = settings.map((subject) {
        return [
          (subject['grade'] ?? '').toString(),
          (subject['gpa_value'] ?? '').toString(),
          (subject['id'] ?? '').toString(),
        ];
      }).toList();
    });
    // Notify parent that the table is updated
    widget.onTableUpdated?.call(true);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double cellHeight = screenHeight * 0.07;
    double fontSize = screenWidth * 0.03;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (rows.isEmpty)
              const Center(child: CircularProgressIndicator())
            else
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1.2),
                },
                border: const TableBorder.symmetric(),
                children: [
                  // Header row
                  _buildTableRow(["Grade", "GPA value", "Actions"],
                      isHeader: true, fontSize: fontSize, cellHeight: cellHeight),
                  // Data rows with Edit buttons
                  for (var row in rows)
                    _buildTableRow(
                      row.sublist(0, 3),
                      fontSize: fontSize,
                      cellHeight: cellHeight,
                      editButton: () {
                        int dataId;
                        try {
                          dataId = int.parse(row[2]);
                          print(row);
                        } catch (e) {
                          dataId = -1; // Handle non-numeric grades properly
                        }
                        
                        _editRow(context, row[0], row[1],dataId);
                      },
                    ),
                ],
              ),
          ],
        ),
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
      ) // Header background
          : const BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: textParagraph,
            width: 1.0,
          ),
          left: BorderSide(
            color: textParagraph,
            width: 1.0,
          ),
          right: BorderSide(
            color: textParagraph,
            width: 1.0,
          ),
        ),
      ),
      children: [
        for (int i = 0; i < data.length; i++)
          Container(
            height: cellHeight,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: i == data.length - 1 && !isHeader
                ? IconButton(
              icon: const Icon(Icons.edit, color: textSecondaryColor),
              onPressed: editButton,
            )
                : Text(
              data[i],
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                color: isHeader ? textTableHeader : textParagraph,
              ),
              textAlign: TextAlign.left,
            ),
          ),
      ],
    );
  }

  void _editRow(BuildContext context, String grade, String gpa, int id) {

    TextEditingController gradeController = TextEditingController(text: grade);
    TextEditingController gpaController = TextEditingController(text: gpa);

    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: darkBackground,
        title: const Text('Edit Grade',
            style: TextStyle(
              color: textSecondaryColor,
              fontFamily: primaryFont,
            )
        ),
        content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  readOnly: true,
                  controller: gradeController,
                  style: const TextStyle(
                    color: textParagraph,
                    fontFamily: primaryFont,
                  ),
                  // initialValue: grade,
                  decoration: const InputDecoration(
                      labelText: 'Grade',
                      labelStyle: TextStyle(color: textParagraph)
                  ),
                ),
                TextFormField(
                  controller: gpaController,
                  style: const TextStyle(
                    color: textParagraph,
                    fontFamily: primaryFont,
                  ),
                  // initialValue: gpa,
                  decoration: const InputDecoration(
                      labelText: 'GPA Value',
                      labelStyle: TextStyle(color: textParagraph)),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),)
        ,
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
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                String updatedGrade = gradeController.text;
                String updatedGpa = gpaController.text;

                // Check if any value has changed
                if (updatedGrade == grade && updatedGpa == gpa ) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: textSecondaryColor,
                      content: Text("Nothing to update"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  return;
                }

                SettingController subjectController = SettingController();
                await subjectController.updateSetting(id, updatedGrade, double.parse(updatedGpa));
                loadAll();
                Navigator.of(context).pop();
              }
            },
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
