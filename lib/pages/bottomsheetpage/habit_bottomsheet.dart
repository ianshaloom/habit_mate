import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../models/habit_database.dart';

class ViewHabitBottomSheet extends StatefulWidget {
  final int habitIndex;
  final String habit;
  final bool status;
  final DateTime date;
  final Function deleteHabit;

  const ViewHabitBottomSheet({
    super.key,
    required this.habitIndex,
    required this.habit,
    required this.status,
    required this.date,
    required this.deleteHabit,
  });

  @override
  State<ViewHabitBottomSheet> createState() => _ViewHabitBottomSheetState();
}

class _ViewHabitBottomSheetState extends State<ViewHabitBottomSheet> {
  final PageController _pageController = PageController();
  final HabitDb _a = HabitDb();

  void _switchPages(int pageIndex) {
    setState(() {
      _pageController.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  int index = 0;

  newPageIndex(int value) {
    setState(() {
      index = value;
    });
  }

  // cancel adding
  void onCancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: 200,
        padding: const EdgeInsets.only(top: 5, bottom: 15.0, left: 4, right: 4),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: onCancel,
                  icon: const Icon(CupertinoIcons.xmark),
                ),
                index == 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ' Status: ',
                            maxLines: 4,
                            style: GoogleFonts.hubballi(
                              color: const Color(0xff000000),
                              fontSize: 16,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            widget.status ? "Completed" : 'Not Completed',
                            style: GoogleFonts.hubballi(
                              color: widget.status
                                  ? const Color(0xff009108)
                                  : const Color(0xffC10000),
                              fontSize: 16,
                              height: 1.2,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        ' Streaks',
                        maxLines: 4,
                        style: GoogleFonts.hubballi(
                          color: const Color(0xff000000),
                          fontSize: 18,
                        ),
                      ),
                IconButton(
                  onPressed: () => widget.deleteHabit(widget.habitIndex),
                  icon: const Icon(CupertinoIcons.delete),
                ),
              ],
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (value) => newPageIndex(value),
                children: [_page1(), _page2()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _page1() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 25, left: 8),
                child: Text(
                  widget.habit,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    //fontWeight: FontWeight.bold,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(44, 49, 64, 1),
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                'Date Added: ${DateFormat.yMMMd().format(widget.date)}',
                style: GoogleFonts.hubballi(
                  color: const Color(0xff939191),
                  fontSize: 14,
                  letterSpacing: 1.5,
                ),
              )
            ],
          ),
        ),
        IconButton(
          onPressed: () => _switchPages(1),
          icon: const Icon(CupertinoIcons.forward),
          splashColor: Colors.transparent,
        )
      ],
    );
  }

  NumberFormat numberFormat = NumberFormat("00");
  Widget _page2() {
    final int currentStreak = _a.getCurrentStreak(widget.habitIndex);
    final int highestStreak = _a.getHighestStreak(widget.habitIndex);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () => _switchPages(0),
          icon: const Icon(CupertinoIcons.back),
          splashColor: Colors.transparent,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.transparent,
                          child: SvgPicture.asset(
                            'assets/images/currentstreak.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        Positioned(
                          top: 10,
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                numberFormat.format(currentStreak),
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromRGBO(44, 49, 64, 1),
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Current Streak',
                          style: GoogleFonts.hubballi(
                            color: const Color(0xff939191),
                            fontSize: 17,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.transparent,
                          child: SvgPicture.asset(
                            'assets/images/beststreak.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        Positioned(
                          top: 10,
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                numberFormat.format(highestStreak),
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromRGBO(44, 49, 64, 1),
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Highest Streak',
                          style: GoogleFonts.hubballi(
                            color: const Color(0xff939191),
                            fontSize: 17,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
