import 'package:flutter/material.dart';

class UserInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final void Function(String)? onSubmitted;

  const UserInputField({
    super.key,
    required this.controller,
    this.hintText,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(26, 105, 105, 105),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            hintText: hintText ?? 'Habit Name',
            hintStyle: const TextStyle(
              fontSize: 18,
              color: Color.fromARGB(157, 44, 49, 64),
              fontWeight: FontWeight.w400,
            ),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          style: Theme.of(context).textTheme.bodyMedium,
          cursorColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
