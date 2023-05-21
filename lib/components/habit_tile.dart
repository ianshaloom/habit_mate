import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class HabitTile extends StatelessWidget {
  HabitTile({
    super.key,
    required this.habitName,
    required this.habitCompleted,
    required this.onChanged,
    required this.edit,
    required this.delete,
  });

  final String habitName;
  final bool habitCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? edit;
  Function(BuildContext)? delete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: edit,
              backgroundColor: const Color.fromARGB(255, 66, 66, 66),
              icon: Icons.edit_note_sharp,
              borderRadius: BorderRadius.circular(8),
            ),
            SlidableAction(
              onPressed: delete,
              backgroundColor: const Color.fromARGB(255, 121, 0, 0),
              icon: Icons.delete_outlined,
              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Checkbox(
                value: habitCompleted,
                onChanged: onChanged,
              ),
              Text(
                habitName,
                style: GoogleFonts.shadowsIntoLightTwo(
                  decoration: habitCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
