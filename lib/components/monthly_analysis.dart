import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/datetime/date_time.dart';

class MonthAnalysis extends StatelessWidget {
  final Map<DateTime, int>? dataset;
  final String startDate;
  final String tips = '''
1. Keep a manageble list of habits, 10 Max
2. Let your habit be less that 25 character you dont wanna keep paragraph of text
3. Slide habit to the left to Delete or Edit
4. You retain all the habits, the stronger the color becomes on the heatmap
5. Habit heatmap is powerful tool if you've been working on a consistent habit list.
  ''';
  const MonthAnalysis({
    super.key,
    required this.dataset,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeatMap(
            startDate: createDateTimeObj(startDate),
            endDate: DateTime.now().add(Duration(days: 0)),
            datasets: dataset,
            colorMode: ColorMode.color,
            showColorTip: false,
            showText: true,
            scrollable: true,
            size: 30,
            colorsets: const {
              1: Color.fromRGBO(44, 49, 64, 0.1),
              2: Color.fromRGBO(44, 49, 64, 0.2),
              3: Color.fromRGBO(44, 49, 64, 0.3),
              4: Color.fromRGBO(44, 49, 64, 0.4),
              5: Color.fromRGBO(44, 49, 64, 0.5),
              6: Color.fromRGBO(44, 49, 64, 0.6),
              7: Color.fromRGBO(44, 49, 64, 0.7),
              8: Color.fromRGBO(44, 49, 64, 0.8),
              9: Color.fromRGBO(44, 49, 64, 0.9),
              10: Color.fromRGBO(44, 49, 64, 1),
            },
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(44, 49, 64, 1),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 1.0,
                    color: Color(0x33000000),
                    offset: Offset(5, 5))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Tips 💡',
                  style: GoogleFonts.shadowsIntoLightTwo(
                      fontSize: 16,
                      color: const Color(0xffe8eeff),
                      fontWeight: FontWeight.w600,
                    ),
                ),
                Text(
                  tips,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.shadowsIntoLightTwo(
                    fontSize: 16,
                    color: const Color(0xffe8eeff),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
