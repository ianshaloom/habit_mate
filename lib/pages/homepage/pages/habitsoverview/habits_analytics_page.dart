import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../models/analytics.dart';
import 'widgets/habits_history.dart';
import 'widgets/heatmap.dart';

class HabitsAnalytics extends StatelessWidget {
  final Map<DateTime, int>? dataset;
  final String startDate;
  final Function onPressed;

  HabitsAnalytics({
    super.key,
    required this.dataset,
    required this.startDate,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                onPressed(context);
              },
              icon: const Icon(Icons.menu),
              color: const Color.fromRGBO(44, 49, 64, 1),
              splashColor: Colors.transparent,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: AnalyticHeatMap(startDate: startDate, dataset: dataset),
        ),
        const Divider(),
        Flexible(
          child: SizedBox(
              child: a.generated.isEmpty
                  ? Center(
                      child: Text(
                        "You'll Get Your Past Habits Soon",
                        style: GoogleFonts.hubballi(
                          fontSize: 18,
                          color: const Color.fromRGBO(44, 49, 64, 1),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : const HabitsHistory()),
        ),
      ],
    );
  }

  final Analytics a = Analytics();
  final NumberFormat numberFormat = NumberFormat("00");
}
