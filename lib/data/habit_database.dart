import 'package:habit_tracker/datetime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

// reference our database
final _mybox = Hive.box('Habit_Database');

class HabitDb {
  List habits = [];
  Map<DateTime, int> heatMapDataset = {};

  // create initial default database
  void createDefaultDb() {
    // create a list of habits
    habits = [
      ['Keep hydrated', false],
      ['Be grateful for everything', false],
      ['Learn something new', false]
    ];

    _mybox.put('START_DATE', todaysDate());
  }

  //  load data if already exixsts
  void loadCurrentDB() {
    // if its a new day, get habit list from database
    if (_mybox.get(todaysDate()) == null) {
      habits = _mybox.get('CURRENT_HABIT_LIST');
      // set all habits to false
      for (int i = 0; i < habits.length; i++) {
        habits[i][1] = false;
      }

      // if its not a new day, load todays list
    } else {
      habits = _mybox.get(todaysDate());
    }
  }

  // update database
  void updateCurrentDb() {
    // update todays habits
    _mybox.put(todaysDate(), habits);

    // update habits list incase of operations
    _mybox.put('CURRENT_HABIT_LIST', habits);

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
    _mybox.put('PERCENTAGE_SUMMARY_${todaysDate()}', percent);
  }

  loadHeatMap() {
    DateTime startDate = createDateTimeObj(_mybox.get('START_DATE'));

    // count the number of days to load
    int daysBetween = DateTime.now().difference(startDate).inDays;

    // go from start date to today while adding each percentage
    for (int i = 0; i < daysBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double streghthAsPercent = double.parse(
        _mybox.get('PERCENTAGE_SUMMARY_$yyyymmdd') ?? '0.0',
      );

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
}
