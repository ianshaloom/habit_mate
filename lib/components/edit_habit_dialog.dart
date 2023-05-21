import 'package:flutter/material.dart';

class EditDialog extends StatelessWidget {
  const EditDialog({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onSave,
    required this.onCancel,
  });

  final controller;
  final hintText;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Edit Habit',
        style: TextStyle(color: Color(0xFF2c3140)),
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
              controller: controller,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                icon: const Icon(Icons.edit),
                hintText: hintText,
                border: InputBorder.none,
              ),
              autofocus: true,
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
