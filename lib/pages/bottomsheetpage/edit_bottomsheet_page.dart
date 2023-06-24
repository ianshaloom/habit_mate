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
                  controller: widget.controller,
                  hintText: widget.hintText,
                  onSubmitted: (_) => widget.editHabit(),
                ),
              ),
              IconButton(
                onPressed: widget.editHabit,
                icon: const Icon(CupertinoIcons.check_mark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
