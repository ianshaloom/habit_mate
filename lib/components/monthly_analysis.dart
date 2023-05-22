import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/datetime/date_time.dart';

class MonthAnalysis extends StatelessWidget {
  final Map<DateTime, int>? dataset;
  final String startDate;
  const MonthAnalysis({
    super.key,
    required this.dataset,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: HeatMap(
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
        onClick: (value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );
  }
}
