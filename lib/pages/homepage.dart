import 'package:flutter/material.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/add_habit_dialog.dart';
import 'package:habit_tracker/components/edit_habit_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Habit name Text Controller
  final _controller = TextEditingController();

  // create a list of habits
  List habits = [
    ['Read two pages', false],
    ['Take a walk', false],
    ['Learn a new widget', false]
  ];

  // checkBox Tapped
  void checkBaxTapped(bool? value, index) {
    setState(() {
      habits[index][1] = value;
    });
  }

  // create new habit
  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return NewHabitDialog(
          controller: _controller,
          onSave: onSave,
          onCancel: onCancel,
        );
      },
    );
  }

  // save new habit
  void onSave() {
    setState(() {
      habits.add([_controller.text.trim(), false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  // cancel adding
  void onCancel() {
    Navigator.of(context).pop();
    _controller.clear();
  }

  // delete habit
  void deleteHabit(int index) {
    setState(() {
      habits.removeAt([index][0]);
    });
  }

  // Open habit setting
  void editHabit(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return EditDialog(
          controller: _controller,
          hintText: habits[index][0],
          onSave: () => onEdit(index),
          onCancel: onCancel,
        );
      },
    );
  }

  // edit existing habit
  void onEdit(int index) {
    setState(() {
      habits[index][0] = _controller.text;
    });
    _controller.clear();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe8eeff),
      appBar: AppBar(
        title: const Text(
          'Habit Tracker',
        ),
        backgroundColor: const Color(0xFF2c3140),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          return HabitTile(
            habitName: habits[index][0],
            habitCompleted: habits[index][1],
            onChanged: (value) => checkBaxTapped(value, index),
            edit: (context) => editHabit(index),
            delete: (context) => deleteHabit(index),
          );
        },
      ),
    );
  }
}
