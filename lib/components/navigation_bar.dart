import 'package:flutter/material.dart';
import 'package:gpa_cal/constant.dart';
import 'package:gpa_cal/screens/add.dart';
import 'package:gpa_cal/screens/settings.dart';
import 'package:gpa_cal/screens/summery.dart';

/// A stateful widget that represents the bottom navigation bar
/// for the GPA app.
///
/// This navigation bar allows users to switch between:
/// - **Summery** screen
/// - **Add Information** screen
/// - **Settings** screen

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {

  /// Tracks the currently selected navigation index.
  int selectedIndex = 0;
  /// List of screens corresponding to each navigation destination.
  List<Widget> screens = [
    Summery(),// Summary screen
    AddInfo(),// Add information screen
    Settings(),// Settings screen
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,

        /// Updates the selected index when a navigation item is tapped.
        onDestinationSelected: (int index) {
          setState(
            () {
              selectedIndex = index;
            },
          );
        },
        backgroundColor: backgroundColor1,
        indicatorColor: textSecondaryColor,
        destinations: const <Widget>[

          /// Navigation option for the Summery screen.
          NavigationDestination(
            icon: Icon(Icons.list), label: "Summery"),
          /// Navigation option for adding new information.
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline), label: "Add"),
          /// Navigation option for the Settings screen.
          NavigationDestination(
            icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),

      /// Displays the selected screen based on selectedIndex.
      body: screens[selectedIndex],
    );
  }
}
