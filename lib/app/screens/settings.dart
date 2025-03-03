import 'package:flutter/material.dart';
import 'package:gpa_cal/app/components/settings_table.dart';
import 'package:gpa_cal/constant.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: darkBackground,
        body: SafeArea(
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
                        child: SingleChildScrollView(
                          child: SettingsTable(
                            onTableUpdated: (bool status) {
                              if (status) {
                                setState(() {}); // Refresh UI
                              }
                            },
                          ),
                        ))),
              ],
            )));
  }
}
