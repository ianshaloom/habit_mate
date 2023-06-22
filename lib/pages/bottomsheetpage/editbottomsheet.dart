import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/habit_database.dart';
import 'widgets/textinput.dart';

class EditBottomSheetContent extends StatefulWidget {
  final void Function() editHabit;
  final String hintText;
  final TextEditingController controller;

  const EditBottomSheetContent({
    super.key,
    required this.controller,
    required this.editHabit,
    required this.hintText,
  });

  @override
  State<EditBottomSheetContent> createState() => _EditBottomSheetContentState();
}

class _EditBottomSheetContentState extends State<EditBottomSheetContent> {
  HabitDb a = HabitDb();
  // cancel adding
  void onCancel() {
    Navigator.of(context).pop();
    widget.controller.clear();
  }

  // Get Date Picker
  //DateTime _selectedDate = DateTime.now();

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
                  'Edit Habit',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                IconButton(
                  onPressed: widget.editHabit,
                  icon: const Icon(CupertinoIcons.check_mark),
                ),
              ],
            ),
          ),
          UserInputField(
            controller: widget.controller,
            hintText: widget.hintText,
            onSubmitted: (_) => widget.editHabit(),
          ),
        ],
      ),
    );
  }
}
