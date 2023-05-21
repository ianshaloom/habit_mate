import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewHabitDialog extends StatelessWidget {
  const NewHabitDialog({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'New Habit',
        style: GoogleFonts.poppins(
          color: const Color(0xFF2c3140),
        ),
      ),
      backgroundColor: const Color(0xffaabdf8),
      content: Container(
        height: 100,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              autofocus: true,
              controller: controller,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                icon: Icon(Icons.edit),
                hintText: 'Add new Habit',
                border: InputBorder.none,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onSave,
                  child: const Text(
                    'Save',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: onCancel,
                  child: const Text(
                    'Cancel',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
