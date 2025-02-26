import 'package:flutter/material.dart';
import 'package:gpa_cal/constant.dart';

class TableWidget extends StatelessWidget {
  const TableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Define responsive sizes based on screen dimensions
    double cellHeight = screenHeight * 0.07;
    double fontSize = screenWidth * 0.03;

    List<List<String>> rows = [
      ["6", "CCSXXXX", "Cloud Application Development", "C"],
      ["6", "CCSXXXX", "Cloud Application Development", "C"],
      ["6", "CCSXXXX", "Cloud Application Development", "C"],
    ];

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
              icon: const Icon(Icons.edit, color: textPrimaryColor),
              onPressed: editButton,
              style: const ButtonStyle(
                alignment: Alignment.centerLeft,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCell(String text, double fontSize, double cellHeight) {
    return Container(
      height: cellHeight,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, color: textParagraph),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildEditCell(VoidCallback? editButton, double cellHeight) {
    return Container(
      height: cellHeight,
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: const Icon(Icons.edit, color: Colors.blue),
        onPressed: editButton,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 50),
      ),
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
