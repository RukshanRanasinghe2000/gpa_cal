import 'package:flutter/material.dart';
import 'package:gpa_cal/components/settings_table.dart';
import 'package:gpa_cal/constant.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: darkBackground,
        body: SafeArea(
            child: Container(
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
                    "Settings",
                    style: TextStyle(
                      fontFamily: primaryFont,
                      fontSize: screenWidth * 0.1,
                      fontWeight: FontWeight.w600,
                      color: textSecondaryColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.01,
                        right: screenWidth * 0.01,
                        top: screenHeight * 0.02,
                      ),
                      child: const SingleChildScrollView(
                        child: SettingsTable(),
                      ))),
            ],
          ),
        )));
  }
}
