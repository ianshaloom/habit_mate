import 'package:hive_flutter/hive_flutter.dart';


final _mybox1 = Hive.box('Habit_Database');
final _mybox2 = Hive.box('Habit_Percent');

class Analytics {
  static final Analytics _instance = Analytics._internal();
  factory Analytics() {
    return _instance;
  }
  Analytics._internal();

  //                                                            \\
  //           // >>>> FUNCTIONS START HERE <<<< \\             \\
  //                                                            \\
  //                                                            \\

  List generated = [];

  // Get completed habits for all days
  generateCompletedHabits() {
    List habits = [];
    List completed = [];

    _mybox1.toMap().forEach((key, value) {
      habits = value;

      int countCompleted = 0;
      for (int i = 0; i < habits.length; i++) {
        if (habits[i][1] == true) {
          countCompleted++;
        }
      }

      completed.add([key, countCompleted]);
    });

    _mybox2.put('COMPLETED', completed);

    completed = _mybox2.get('COMPLETED');

    generated = completed.reversed.toList();
  }
}
