import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit_tracker/pages/homepage/pages/yourhabits/widgets/habit_tile.dart';

import 'widgets/disable_list_glow.dart';
import '../../../../models/habit_database.dart';

class HabitsPage extends StatelessWidget {
  final Function checkBaxTapped;
  final Function editHabitForm;
  final Function deleteHabit;
  final Function onTap;
  final HabitDb db = HabitDb();

  HabitsPage({
    super.key,
    required this.checkBaxTapped,
    required this.editHabitForm,
    required this.deleteHabit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 8, left: 8, top: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                'assets/images/homegym.svg',
                width: (size.width - 16) * 0.5, // Adjust the width as needed
                height: 100,
                fit: BoxFit.fitWidth, // Adjust the height as needed
              ),
              SvgPicture.asset(
                'assets/images/dogwalk.svg',
                width: (size.width - 16) * 0.5, // Adjust the width as needed
                height: 100,
                fit: BoxFit.fitWidth, // Adjust the height as needed
              ),
            ],
          ),
        ),
        db.habits.isEmpty
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
                child: GlowingOverscrollWrapper(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 20, left: 3, right: 3),
                    itemCount: db.habits.length,
                    itemBuilder: (context, index) {
                      return HabittTile(
                        habitIndex: index,
                        habitName: db.habits[index][0],
                        habitCompleted: db.habits[index][1],
                        dateAdded: db.habits[index][2],
                        onChanged: (value) => checkBaxTapped(value, index),
                        onTap: onTap,
                      );
                    },
                  ),
                ),
              )
      ],
    );
  }
}
