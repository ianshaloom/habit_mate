import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../models/habit_database.dart';

HabitDb _a = HabitDb();

class HabittTile extends StatelessWidget {
  final int habitIndex;
  final String habitName;
  final DateTime dateAdded;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function onTap;

  const HabittTile({
    super.key,
    required this.habitIndex,
    required this.habitName,
    required this.dateAdded,
    required this.habitCompleted,
    required this.onChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String currentStreak = _a.getCurrentStreak(habitIndex).toString();
    return Card(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Checkbox(
              value: habitCompleted,
              onChanged: onChanged,
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.all(const Color(0xff6C63FF)),
              shape: const CircleBorder(),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 0,
            child: SvgPicture.asset(
              'assets/images/fun-underline.svg',
              height: 28,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: InkWell(
              overlayColor: MaterialStateProperty.all(
                Colors.transparent,
              ),
              onTap: () => onTap(
                  context, habitIndex, habitName, habitCompleted, dateAdded),
              child: Container(
                //margin: const EdgeInsets.only(left: 40),
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            habitName,
                            style: GoogleFonts.montserrat(
                              fontSize: 17,
                              //fontWeight: FontWeight.bold,
                              fontWeight: habitCompleted
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                              color: const Color.fromRGBO(44, 49, 64, 1),
                              decoration: habitCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            'Date Added: ${DateFormat.yMMMd().format(dateAdded)}',
                            style: GoogleFonts.hubballi(
                              color: const Color(0xff939191),
                              fontSize: 14,
                              letterSpacing: 1.5,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3, right: 8, left: 8),
                      child: Text(
                        ' Current Streak: $currentStreak',
                        maxLines: 4,
                        style: GoogleFonts.hubballi(
                          color: const Color(0xff000000),
                          fontSize: 14,
                          height: 1.2,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
