import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditDialog extends StatefulWidget {
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
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  String? errorText;
  bool buttonEnabled = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Edit Habit',
        style: GoogleFonts.poppins(
          color: const Color(0xffe8eeff),
        ),
      ),
      backgroundColor: const Color(0xff2c3140),
      content: Container(
        height: 120,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              autofocus: true,
              controller: widget.controller,
              textInputAction: TextInputAction.done,
              onChanged: (value) {
                if (value.length > 30) {
                  setState(() {
                    errorText = 'Max of 30 characters!';
                    buttonEnabled = false;
                  });
                } else {
                  setState(() {
                    errorText = null;
                    buttonEnabled = true;
                  });
                }
              },
              decoration: InputDecoration(
                icon: const Icon(Icons.edit),
                iconColor: const Color(0xffe8eeff),
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: Color(0xffe8eeff),
                ),
                errorText: errorText,
              ),
              style: GoogleFonts.shadowsIntoLightTwo(
                fontSize: 16,
                color: const Color(0xffe8eeff),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: widget.onSave,
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: widget.onCancel,
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16,
                    ),
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
