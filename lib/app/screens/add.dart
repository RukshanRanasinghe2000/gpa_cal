import 'package:flutter/material.dart';
import 'package:gpa_cal/constant.dart';

class AddInfo extends StatelessWidget {
  const AddInfo({super.key});

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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.10,
                  right: screenWidth * 0.10,
                  top: screenHeight * 0.07,
                  bottom: 0,
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
              Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.10,
                    right: screenWidth * 0.10,
                    top: screenHeight * 0.03,
                    bottom: 0,
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Semester',
                      labelStyle: TextStyle(color: textParagraph)
                    ),
                    style: const TextStyle(
                      color: textParagraph,
                      fontFamily: primaryFont,
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.10,
                    right: screenWidth * 0.10,
                    top: screenHeight * 0.03,
                    bottom: 0,
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Module code',
                      labelStyle: TextStyle(color: textParagraph)
                    ),
                    style: const TextStyle(
                      color: textParagraph,
                      fontFamily: primaryFont,
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.10,
                    right: screenWidth * 0.10,
                    top: screenHeight * 0.03,
                    bottom: 0,
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Name',
                      labelStyle: TextStyle(color: textParagraph)
                    ),
                    style: const TextStyle(
                      color: textParagraph,
                      fontFamily: primaryFont,
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.10,
                    right: screenWidth * 0.10,
                    top: screenHeight * 0.03,
                    bottom: 0,
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Grade',
                      labelStyle: TextStyle(color: textParagraph)
                    ),
                    style: const TextStyle(
                      color: textParagraph,
                      fontFamily: primaryFont,
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.10,
                    right: screenWidth * 0.10,
                    top: screenHeight * 0.07,
                    bottom: 0,
                  ),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(textSecondaryColor),
                        ),
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: textTableHeader,
                            fontSize: screenWidth * 0.05,
                          ),
                        ),
                      )))
            ],
          ),
        )));
  }
}
