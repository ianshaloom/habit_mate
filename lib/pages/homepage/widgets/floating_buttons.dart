import 'package:flutter/material.dart';

class QuickShortcuts extends StatelessWidget {
  final void Function()? onAdd;
  final void Function()? onClear;
  final int pageIndex;
  const QuickShortcuts({
    super.key,
    required this.onAdd,
    required this.onClear,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 3, right: 3),
          height: 65,
          width: 130,
          decoration: const BoxDecoration(
            color: Color.fromARGB(88, 44, 49, 64),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: FloatingActionButton(
                  //mini: true,
                  onPressed: onAdd,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 2.0),
                child: FloatingActionButton(
                  //mini: true,
                  onPressed: onClear,
                  child: const Icon(
                    Icons.clear_all_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
