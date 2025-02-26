import 'package:flutter/material.dart';
import 'package:gpa_cal/constant.dart';

class SettingsTable extends StatelessWidget {
  const SettingsTable({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double cellHeight = screenHeight * 0.07;
    double fontSize = screenWidth * 0.03;

    // List of rows with grade and GPA value
    List<List<String>> rows = [
      ["A+", "4"],
      ["A", "4"],
      ["A-", "3.7"],
      ["B+", "3.3"],
      ["B", "3.0"],
      ["B-", "2.7"],
      ["C+", "2.3"],
      ["C", "2.0"],
      ["C-", "1.7"],
      ["D+", "1.3"],
      ["D", "1"],
      ["E", "0.7"],
      ["E", "0.0"],
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: SingleChildScrollView(
        child: Column(
          children: [
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
                    [...row, ""], // Add empty for Edit button cell
                    fontSize: fontSize,
                    cellHeight: cellHeight,
                    editButton: () => _editRow(context, row[0], row[1]),
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

  void _editRow(BuildContext context, String grade, String gpa) {
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
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              style: const TextStyle(
                color: textParagraph,
                fontFamily: primaryFont,
              ),
              initialValue: grade,
              decoration: const InputDecoration(
                labelText: 'Grade',
                labelStyle: TextStyle(color: textParagraph)
                ),
            ),
            TextFormField(
              style: const TextStyle(
                color: textParagraph,
                fontFamily: primaryFont,
              ),
              initialValue: gpa,
              decoration: const InputDecoration(
                labelText: 'GPA Value',
                labelStyle: TextStyle(color: textParagraph)),
              keyboardType: TextInputType.number,
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
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all<Color>(textSecondaryColor),
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
