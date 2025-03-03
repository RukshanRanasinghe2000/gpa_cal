import 'package:flutter/material.dart';
import 'package:gpa_cal/app/components/navigation_bar.dart';
import 'package:gpa_cal/app/data/database.dart';
import 'package:gpa_cal/constant.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'app/data/controllers/settings_controller.dart';

Future<void> main() async {
  runApp(const MyApp());
  final DatabaseConnection _databaseConnection = DatabaseConnection();
  _databaseConnection.initDatabase();

  final SettingController settings = SettingController();
  settings.insertDefaultSettings();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GPA Calculator',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          navigationBarTheme: NavigationBarThemeData(
              backgroundColor: darkBackground,
              indicatorColor: textSecondaryColor,
              labelTextStyle:
                  WidgetStateProperty.resolveWith((Set<WidgetState> states) {
                    if (states.contains(WidgetState.selected)) {
                      return const TextStyle(color: textSecondaryColor);
                    } else {
                      return const TextStyle(color: text);
                    }
              }),
              iconTheme:
                  WidgetStateProperty.resolveWith((Set<WidgetState> states) {
                    if (!states.contains(WidgetState.selected)) {
                     return const IconThemeData(color: text);
                    }
              })),
        ),
        home: const AppNavigationBar());
  }
}
