import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize hive
  await Hive.initFlutter();

  // open a database
  await Hive.openBox('Habit_Database');

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habit Tracker',
      home: HomePage(),
    ),
  );
}
