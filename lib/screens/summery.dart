import 'package:flutter/material.dart';
import 'package:gpa_cal/components/table.dart';
import 'package:gpa_cal/constant.dart';

class Summery extends StatelessWidget {
  const Summery({super.key});

  @override
  Widget build(BuildContext context) {
    /// Get screen width & height
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
                  top: screenHeight * 0.13,
                  bottom: 0,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Current GPA",
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
                  top: 0,
                  bottom: 0,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "2.25",
                    style: TextStyle(
                      fontFamily: primaryFont,
                      fontSize: screenWidth * 0.2,
                      fontWeight: FontWeight.w600,
                      color: textPrimaryColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.01,
                  right: screenWidth * 0.01,
                  top: 0,
                  bottom: 0,
                ),
                child: const TableWidget(),
              )
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
