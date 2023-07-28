import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalyticsHabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;

  const AnalyticsHabitTile({
    super.key,
    required this.habitName,
    required this.habitCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 8, bottom: 8, top: 8),
          child: habitCompleted
              ? const Icon(
                  CupertinoIcons.check_mark,
                  color: Color(0xff6C63FF),
                )
              : const Icon(
                  CupertinoIcons.xmark,
                  color: Color(0xffC10000),
                ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 60, right: 8, bottom: 8, top: 8),
          margin: const EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                habitName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: const Color.fromRGBO(44, 49, 64, 1),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
