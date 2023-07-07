import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/bottomsheetpage/widgets/clear_habits.dart';
import 'package:habit_tracker/pages/homepage/widgets/heatmap_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/habit_database.dart';
import '../bottomsheetpage/add_bottomsheet_page.dart';
import '../bottomsheetpage/edit_bottomsheet_page.dart';
import 'widgets/floating_buttons.dart';
import 'widgets/habits_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  HabitDb a = HabitDb();
  final _mybox = Hive.box('Habit_Database');
  String? errorText;

  // Habit name Text Controller
  final _controller = TextEditingController();
  late int _pageIndex = 0;
  final _pageController = PageController();

  // set page new index onchanged
  void _setPageIndex(int value) {
    setState(() {
      _pageIndex = value;
    });
  }

  // checkBox Tapped
  void _checkBoxTapped(bool? value, index) {
    setState(() {
      a.habits[index][1] = value;
    });
    a.updateCurrentDb();
  }

  // delete habit
  void _deleteHabit(int index) {
    setState(() {
      a.habits.removeAt([index][0]);
    });
    a.updateCurrentDb();
  }

  void _confirmClear(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
        side: BorderSide(
          color: Color.fromRGBO(44, 49, 64, 1),
        ),
      ),
      builder: (bCtx) => DeleteBottomSheet(onPressed: _deleteAllHabits),
    );
  }

  // delete all habit
  void _deleteAllHabits() {
    setState(() {
      a.habits.clear();
    });
    a.updateCurrentDb();
    Navigator.of(context).pop();
  }

  // draw add new habit bottom sheet
  void _addHabitForm(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) => AddBottomSheetContent(addHabit: _addHabit),
    );
  }

// Adding a new Habit
  void _addHabit({required String habit, required bool complited}) {
    final newHabit = [habit, complited];
    setState(() {
      a.habits.add(newHabit);
    });
    a.updateCurrentDb();
  }

  // draw edit bottom sheet
  void _editHabitForm(BuildContext ctx, int index) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) => EditBottomSheetContent(
        controller: _controller,
        hintText: a.habits[index][0],
        editHabit: () => _editHabit(index),
      ),
    );
  }

// Edit habit
  void _editHabit(int index) {
    setState(() {
      a.habits[index][0] = _controller.text.trim();
    });
    _controller.clear();
    Navigator.of(context).pop();
    a.updateCurrentDb();
  }

  @override
  void initState() {
    //if there is no current habit list, load default
    if (_mybox.get('CURRENT_HABIT_LIST') == null) {
      a.createDefaultDb();

      // else load current database
    } else {
      a.loadCurrentDB();
    }
    a.updateCurrentDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    EdgeInsets pad = MediaQuery.of(context).padding;
    final appbar = AppBar(
      toolbarHeight: 10,
    );
    return Scaffold(
      backgroundColor: const Color.fromRGBO(44, 49, 64, 1),
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: (size.height - appbar.preferredSize.height - pad.top) *
                    0.08,
                padding: const EdgeInsets.only(left: 40, bottom: 15, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _pageIndex == 0
                        ? Row(
                            children: <Widget>[
                              Text(
                                "Your",
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                              Text(
                                ' Habits',
                                style: Theme.of(context).textTheme.bodyLarge,
                              )
                            ],
                          )
                        : Row(
                            children: <Widget>[
                              Text(
                                "Habits",
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                              Text(
                                ' HeatMap',
                                style: Theme.of(context).textTheme.bodyLarge,
                              )
                            ],
                          ),
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: 2,
                      effect: const WormEffect(
                        dotWidth: 20,
                        activeDotColor: Color(0xff6C63FF),
                        dotColor: Color.fromRGBO(250, 250, 250, 0.855),
                        spacing: 20,
                      ),
                    ),
                  ],
                )),
            Container(
              height:
                  (size.height - appbar.preferredSize.height - pad.top) * 0.92,
              decoration: const BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(75.0),
                ),
              ),
              child: Stack(
                children: [
                  PageView(
                    controller: _pageController,
                    onPageChanged: ((value) => _setPageIndex(value)),
                    children: [
                      HabitsPage(
                        checkBaxTapped: _checkBoxTapped,
                        editHabitForm: _editHabitForm,
                        deleteHabit: _deleteHabit,
                      ),
                      SizedBox(
                        height: (size.height -
                                appbar.preferredSize.height -
                                pad.top) *
                            0.92,
                        child: HeatMapAnalysis(
                          dataset: a.heatMapDataset,
                          startDate: _mybox.get('START_DATE'),
                        ),
                      )
                    ],
                  ),
                  _pageIndex == 0
                      ? Positioned(
                          left: 0,
                          right: 20,
                          bottom: 10,
                          child: QuickShortcuts(
                            onAdd: () => _addHabitForm(context),
                            onClear: () => _confirmClear(context),
                            pageIndex: 0,
                          ),
                        )
                      : const Center()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
