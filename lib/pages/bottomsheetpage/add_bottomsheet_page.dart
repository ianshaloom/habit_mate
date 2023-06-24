import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/habit_database.dart';
import 'widgets/textinput.dart';

class AddBottomSheetContent extends StatefulWidget {
  final Function addHabit;
  const AddBottomSheetContent({
    super.key,
    required this.addHabit,
  });

  @override
  State<AddBottomSheetContent> createState() => _AddBottomSheetContentState();
}

class _AddBottomSheetContentState extends State<AddBottomSheetContent> {
  HabitDb a = HabitDb();

  // Contollers
  final _habitName = TextEditingController();

  // validate and save data
  void saveData() {
    final habit = _habitName.text.trim();
    if (habit.isEmpty) {
      return;
    }

    widget.addHabit(habit: habit, complited: false);

    Navigator.of(context).pop();
  }

  // cancel adding
  void onCancel() {
    Navigator.of(context).pop();
    _habitName.clear();
  }

  // Get Date Picker
  //DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: 80,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 5, bottom: 15.0, left: 4, right: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: onCancel,
                icon: const Icon(CupertinoIcons.xmark),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: UserInputField(
                  controller: _habitName,
                  onSubmitted: (_) => saveData(),
                ),
              ),
              IconButton(
                onPressed: saveData,
                icon: const Icon(CupertinoIcons.check_mark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
