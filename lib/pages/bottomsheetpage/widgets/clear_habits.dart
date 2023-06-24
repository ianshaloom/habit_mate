import 'package:flutter/material.dart';

class DeleteBottomSheet extends StatelessWidget {
  final void Function()? onPressed;
  const DeleteBottomSheet({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      height: 90,
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Delete Habits",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(44, 49, 64, 1),
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Text(
                    "Delete All",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Flexible(
                fit: FlexFit.tight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(44, 49, 64, 1),
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Text(
                    "Cancel",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
