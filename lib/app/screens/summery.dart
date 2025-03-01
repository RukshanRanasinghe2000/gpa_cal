import 'package:flutter/material.dart';
import 'package:gpa_cal/app/components/table.dart';
import 'package:gpa_cal/constant.dart';
import '../services/calculate_gpa.dart';

class Summery extends StatelessWidget {
  const Summery({super.key});

  @override
  Widget build(BuildContext context) {
    /// Get screen width & height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    GPAService gpaService = GPAService();

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

              /// Fetch GPA asynchronously
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.10,
                  right: screenWidth * 0.10,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FutureBuilder<String>(
                    future: gpaService.getFinalGPA(), // This will now return Future<String>
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(); // Show loading
                      } else if (snapshot.hasError) {
                        return Text(
                          "Error: ${snapshot.error.toString()}", // Show real error message
                          style: const TextStyle(color: Colors.red),
                        );
                      } else {
                        return Text(
                          snapshot.data!.toString(), // Use the string directly
                          style: TextStyle(
                            fontFamily: primaryFont,
                            fontSize: screenWidth * 0.2,
                            fontWeight: FontWeight.w600,
                            color: textPrimaryColor,
                          ),
                        );
                      }
                    },
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
                    child: TableWidget(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
