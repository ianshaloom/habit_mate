import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'pages/homepage/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize hive
  await Hive.initFlutter();

  // open a database
  await Hive.openBox('Habit_Database');

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habit Tracker',
      home: const MainPage(),
      theme: ThemeData(
        primaryColor: const Color(0xff353535),
        fontFamily: "Montserrat",

        // Appbar Theme
        appBarTheme: const AppBarTheme(
          color: Color(0xff353535),
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),

        // Floating Buttons Theme
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xff353535),
          shape: CircleBorder(),
        ),

        // Card Theme
        cardTheme: const CardTheme(
          elevation: 2,
          color: Color.fromARGB(235, 255, 255, 255),
        ),

        // Text Theme
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 23,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
          bodyMedium: TextStyle(
            fontSize: 18,
            color: Color(0xff2c3140),
            fontWeight: FontWeight.w300,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            color: Color.fromARGB(148, 44, 49, 64),
            fontWeight: FontWeight.w500,
          ),
        ),

        // Bottom Sheet Theme
        bottomSheetTheme: const BottomSheetThemeData(
          modalElevation: 1,
          modalBackgroundColor: Color(0xffffffff),
          modalBarrierColor: Color.fromARGB(123, 44, 49, 64),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
            side: BorderSide(
              color: Color(0xff353535),
            ),
          ),
        ),
      ),
    ),
  );
}
