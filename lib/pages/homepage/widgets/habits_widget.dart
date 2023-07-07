import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'habit_tile.dart';
import '../../../models/habit_database.dart';

class HabitsPage extends StatelessWidget {
  final Function checkBaxTapped;
  final Function editHabitForm;
  final Function deleteHabit;
  final HabitDb habitDb = HabitDb();

  HabitsPage({
    super.key,
    required this.checkBaxTapped,
    required this.editHabitForm,
    required this.deleteHabit,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 8, left: 8, top: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                'assets/images/homegym.svg',
                width: (size.width - 16) * 0.5, // Adjust the width as needed
                height: 120,
                fit: BoxFit.fitWidth, // Adjust the height as needed
              ),
              SvgPicture.asset(
                'assets/images/dogwalk.svg',
                width: (size.width - 16) * 0.5, // Adjust the width as needed
                height: 120,
                fit: BoxFit.fitWidth, // Adjust the height as needed
              ),
            ],
          ),
        ),
        habitDb.habits.isEmpty
            ? Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0, top: 30),
                        child: Text(
                          'No habits added yet!',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/images/arrow.svg',
                        height: 180,
                      ),
                    ],
                  ),
                ),
              )
            : Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 20),
                  itemCount: habitDb.habits.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        HabitTile(
                          habitName: habitDb.habits[index][0],
                          habitCompleted: habitDb.habits[index][1],
                          onChanged: (value) => checkBaxTapped(value, index),
                          edit: (context) => editHabitForm(context, index),
                          delete: (context) => deleteHabit(index),
                        ),
                        Divider(
                          color: Theme.of(context).primaryColor,
                          indent: 40,
                        )
                      ],
                    );
                  },
                ),
              )
      ],
    );
  }
}
