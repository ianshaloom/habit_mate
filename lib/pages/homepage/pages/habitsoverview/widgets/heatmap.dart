import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

import '../../../../../models/date_time.dart';

class AnalyticHeatMap extends StatelessWidget {
  const AnalyticHeatMap({
    super.key,
    required this.startDate,
    required this.dataset,
  });

  final String startDate;
  final Map<DateTime, int>? dataset;

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      startDate: createDateTimeObj(startDate),
      endDate: DateTime.now().add(const Duration(days: 0)),
      datasets: dataset,
      colorMode: ColorMode.color,
      showColorTip: false,
      showText: true,
      scrollable: true,
      fontSize: 14,
      margin: const EdgeInsets.all(10),
      defaultColor: Colors.white,
      textColor: const Color.fromRGBO(44, 49, 64, 1),
      colorsets: const {
        1: Color.fromRGBO(108, 99, 255, 0.1),
        2: Color.fromRGBO(108, 99, 255, 0.2),
        3: Color.fromRGBO(108, 99, 255, 0.3),
        4: Color.fromRGBO(108, 99, 255, 0.4),
        5: Color.fromRGBO(108, 99, 255, 0.5),
        6: Color.fromRGBO(108, 99, 255, 0.6),
        7: Color.fromRGBO(108, 99, 255, 0.7),
        8: Color.fromRGBO(108, 99, 255, 0.8),
        9: Color.fromRGBO(108, 99, 255, 0.9),
        10: Color.fromRGBO(108, 99, 255, 1),
      },
    );
  }
}
