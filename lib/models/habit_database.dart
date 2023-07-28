import 'package:hive_flutter/hive_flutter.dart';

import 'analytics.dart';
import 'date_time.dart';

// reference our database
final _mybox1 = Hive.box('Habit_Database');
final _mybox2 = Hive.box('Habit_Percent');
final Analytics b = Analytics();

class HabitDb {
  static final HabitDb _instance = HabitDb._internal();

  factory HabitDb() {
    return _instance;
  }

  HabitDb._internal();

  List habits = [];
  Map<DateTime, int> heatMapDataset = {};
  Map<String, List<int>> habitStreak = {};

  // create initial default database
  void createDefaultDb() {
    // create a list of habits
    DateTime date = DateTime.now();
    habits = [
      ['Keep hydrated', false, date],
      ['Read a chapter of my novel', false, date],
      ['Affirm and meditate at lunch break', false, date],
      ['Update my Diary as I listen to an interesting podcast', false, date],
    ];

    b.generated = [];
    _mybox2.put('START_DATE', todaysDate());
  }

  //  load data if already exixsts
  void loadCurrentDB() {
    // if its a new day, get habit list from database
    if (_mybox1.get(todaysDate()) == null) {
      habits = _mybox2.get('CURRENT_HABIT_LIST');
      // set all habits to false
      for (int i = 0; i < habits.length; i++) {
        habits[i][1] = false;
      }
      // if its not a new day, load todays list
    } else {
      habits = _mybox1.get(todaysDate());
    }
  }

  // update database
  void updateCurrentDb() {
    // update todays habits
    _mybox1.put(todaysDate(), habits);

    // update habits list incase of operations
    _mybox2.put('CURRENT_HABIT_LIST', habits);

    b.generateCompletedHabits();
    calculateHabitHeatMap();
    loadHeatMap();
  }

  calculateHabitHeatMap() {
    int countCompleted = 0;
    for (int i = 0; i < habits.length; i++) {
      if (habits[i][1] == true) {
        countCompleted++;
      }
    }

    String percent = habits.isEmpty
        ? '0.0'
        : (countCompleted / habits.length).toStringAsFixed(1);

    // key: 'PERCENTAGE_SUMMARY_yyyymmdd'
    // value: String of 1dp
    _mybox2.put('PERCENTAGE_SUMMARY_${todaysDate()}', percent);
  }

  loadHeatMap() {
    DateTime startDate = createDateTimeObj(_mybox2.get('START_DATE'));

    // count the number of days to load
    int daysBetween = DateTime.now().difference(startDate).inDays;

    // go from start date to today while adding each percentage
    for (int i = 0; i < daysBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double streghthAsPercent =
          double.parse(_mybox2.get('PERCENTAGE_SUMMARY_$yyyymmdd') ?? '0.0');

      // Split datetime
      int year = startDate.add(Duration(days: i)).year;
      int month = startDate.add(Duration(days: i)).month;
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * streghthAsPercent).toInt(),
      };

      heatMapDataset.addEntries(percentForEachDay.entries);
    }
  }

  streaks() {
    Map<String, List<bool>> habitStreakMap = {};

    // Loop through the habitsData map
    _mybox1.toMap().forEach((date, habitItems) {
      for (var habitItem in habitItems) {
        String habitName =
            habitItem[0]; // Get the habit name from the habitItem
        bool isTrue = habitItem[1]; // Get the boolean value from the habitItem

        // Check if the habitName is already in the habitStreakMap
        if (!habitStreakMap.containsKey(habitName)) {
          // If not, add a new entry with a list containing the first boolean value
          habitStreakMap[habitName] = [isTrue];
        } else {
          // If yes, append the boolean value to the existing list
          habitStreakMap[habitName]!.add(isTrue);
        }
      }
    });

    //print('Highest streak for each habit:');
    // Loop through the habitStreakMap to calculate and print highest and current streaks
    habitStreakMap.forEach((habitName, boolList) {
      int highestStreak = _calculateHighestStreak(
          boolList); // Calculate highest streak for this habit
      int currentStreak = _calculateCurrentStreak(
          boolList); // Calculate current streak for this habit
      habitStreak[habitName] = [currentStreak, highestStreak];
    });

    _mybox2.put('STREAKS', habitStreak);
  }

// Function to calculate the current streak
  int _calculateCurrentStreak(List<bool> boolList) {
    int currentStreak = 0;
    // Loop through the boolean list in reverse order
    for (int i = boolList.length - 1; i >= 0; i--) {
      // If the value is true, increment the current streak
      if (boolList[i]) {
        currentStreak++;
      } else {
        // If the value is false, break the loop since the streak is broken
        break;
      }
    }
    return currentStreak; // Return the current streak length
  }

// Function to calculate the highest streak
  int _calculateHighestStreak(List<bool> boolList) {
    int currentStreak = 0;
    int highestStreak = 0;

    // Loop through the boolean list
    for (bool value in boolList) {
      if (value) {
        // If the value is true, increment the current streak
        currentStreak++;
        // Update the highest streak if the current streak is greater
        if (currentStreak > highestStreak) {
          highestStreak = currentStreak;
        }
      } else {
        // If the value is false, reset the current streak
        currentStreak = 0;
      }
    }

    return highestStreak; // Return the highest streak length
  }

  // Streaks

  List<dynamic> streaksToList() {
    return habitStreak.entries
        .map((entry) => [entry.key, ...entry.value])
        .toList();
  }

  int getCurrentStreak(int index) {
    if (index >= 0 && index < streaksToList().length) {
      return streaksToList()[index][1];
    } else {
      throw RangeError('Index out of range');
    }
  }

  int getHighestStreak(int index) {
    if (index >= 0 && index < streaksToList().length) {
      return streaksToList()[index][2];
    } else {
      throw RangeError('Index out of range');
    }
  }
}
