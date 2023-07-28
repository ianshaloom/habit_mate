import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../../models/analytics.dart';
import '../../../../../models/date_time.dart';
import '../../yourhabits/widgets/disable_list_glow.dart';
import 'habit_tile.dart';

class HabitsHistory extends StatefulWidget {
  const HabitsHistory({super.key});

  @override
  State<HabitsHistory> createState() => _HabitsHistoryState();
}

class _HabitsHistoryState extends State<HabitsHistory> {
  final PageController _pageController = PageController(
    viewportFraction: 0.85,
  );
  var myMap = {};
  List habits = [];

  @override
  void initState() {
    _mybox1.toMap().forEach((key, value) {
      myMap[key] = value;
    });
    a.generateCompletedHabits();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlowingOverscrollWrapper(
      child: PageView.builder(
        reverse: true,
        controller: _pageController,
        itemCount: a.generated.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5, top: 5),
                child: Text(
                  DateFormat.MMMd()
                      .format(createDateTimeObj(a.generated[index][0])),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Completed Habits',
                    style: GoogleFonts.hubballi(
                      fontSize: 22,
                      color: const Color.fromRGBO(44, 49, 64, 1),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      numberFormat.format(a.generated[index][1]),
                      style: GoogleFonts.montserrat(
                          fontSize: 17, color: const Color(0xff939191)),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Card(
                    child: GlowingOverscrollWrapper(
                      child: ListView.builder(
                        itemCount: getlength(myMap[a.generated[index][0]]),
                        itemBuilder: (context, x) {
                          if (myMap[a.generated[index][0]] == null) {
                            return const Card(elevation: 0);
                          } else {
                            return AnalyticsHabitTile(
                              habitName: myMap[a.generated[index][0]][x][0],
                              habitCompleted: myMap[a.generated[index][0]][x]
                                  [1],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  final Analytics a = Analytics();
  final NumberFormat numberFormat = NumberFormat("00");
  final _mybox1 = Hive.box('Habit_Database');

  int getlength(List<dynamic> val) {
    int x;
    x = val.length;
    return x;
  }
}
