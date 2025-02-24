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
    double cellHeight = screenHeight * 0.07; // Responsive cell height
    double fontSize = screenWidth * 0.03; // Responsive font size

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1), // First column takes more space
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1.8),
        },
        border: const TableBorder.symmetric(
            ),
        children: [
          // Table Header Row
          _buildTableRow(
            ["Sem", "Code", "Module Name", "Grade"],
            isHeader: true,
            fontSize: fontSize,
            cellHeight: cellHeight,
          ),
          // Table Data Rows
          _buildTableRow(
              ["Sem6", "CCSXXXX", "Cloud Application Development", "C"],
              fontSize: fontSize, cellHeight: cellHeight),
          _buildTableRow(
              ["Sem6", "CCSXXXX", "Cloud Application Development", "C"],
              fontSize: fontSize, cellHeight: cellHeight),
          _buildTableRow(
              ["Sem6", "CCSXXXX", "Cloud Application Development", "C"],
              fontSize: fontSize, cellHeight: cellHeight),
          _buildTableRow(
              ["Sem6", "CCSXXXX", "Cloud Application Development", "C"],
              fontSize: fontSize, cellHeight: cellHeight),
        ],
      ),
    );
  }

  // Build table rows
  TableRow _buildTableRow(List<String> data,
      {bool isHeader = false,
      required double fontSize,
      required double cellHeight}) {
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
      children: data.map((text) {
        return Container(
          height: cellHeight,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              color: isHeader ? textTableHeader : textParagraph,
            ),
            textAlign: TextAlign.left,
          ),
        );
      }).toList(),
    );
  }
}
