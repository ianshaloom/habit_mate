import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/habit_database.dart';
import 'widgets/textinput.dart';

class BottomSheetContent extends StatefulWidget {
  final Function addHabit;
  const BottomSheetContent({
    super.key,
    required this.addHabit,
  });

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  HabitDb a = HabitDb();

  // Contollers
  final _habitName = TextEditingController();

  // validate and save data
  void saveData() {
    final habit = _habitName.text.trim();
    if (habit.isEmpty) {
      return;
    }

    widget.addHabit(habit:habit, complited:false);

    Navigator.of(context).pop();
  }

  // cancel adding
  void onCancel() {
    Navigator.of(context).pop();
    _habitName.clear();
  }

  // Get Date Picker
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 5, bottom: 15.0, left: 4, right: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: onCancel,
                  icon: const Icon(CupertinoIcons.xmark),
                ),
                Text(
                  'New Habit',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                IconButton(
                  onPressed: saveData,
                  icon: const Icon(CupertinoIcons.check_mark),
                ),
              ],
            ),
          ),
          UserInputField(
            controller: _habitName,
            onSubmitted: (_) => saveData(),
          ),
        ],
      ),
    );
  }
}
