import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/analytics.dart';
import '../../models/habit_database.dart';
import '../bottomsheetpage/add_bottomsheet_page.dart';
import '../bottomsheetpage/edit_bottomsheet_page.dart';
import '../bottomsheetpage/habit_bottomsheet.dart';
import '../bottomsheetpage/widgets/clear_habits.dart';
import '../navigationpage/navigation_drawer.dart';
import 'pages/habitsoverview/habits_analytics_page.dart';
import 'pages/yourhabits/widgets/disable_list_glow.dart';
import 'pages/yourhabits/widgets/floating_buttons.dart';
import 'pages/yourhabits/habits_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Habit name Text Controller
  final _controller = TextEditingController();
  final _pageController1 = PageController();

  //page index
  int _pageIndex1 = 0;

  // set page new index on page changed
  void _setPageIndex(int value) {
    setState(() {
      _pageIndex1 = value;
    });
  }

  @override
  void initState() {
    //addDataToHiveBox();
    //if there is no current habit list, load default
    if (_mybox2.get('CURRENT_HABIT_LIST') == null) {
      a.createDefaultDb();

      // else load current database
    } else {
      a.loadCurrentDB();
      b.generateCompletedHabits();
    }
    a.updateCurrentDb();
    a.streaks();
    super.initState();
  }

  @override
  void dispose() {
    _pageController1.dispose();
    _controller.dispose();
    super.dispose();
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
                padding: const EdgeInsets.only(left: 40, right: 20),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _pageIndex1 == 0
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
                                  ' Analytics',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )
                              ],
                            ),
                      SmoothPageIndicator(
                        controller: _pageController1,
                        count: 2,
                        effect: const WormEffect(
                          dotWidth: 20,
                          activeDotColor: Color(0xff6C63FF),
                          dotColor: Color.fromRGBO(250, 250, 250, 0.855),
                          spacing: 20,
                        ),
                      ),
                    ],
                  ),
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
                  GlowingOverscrollWrapper(
                    child: PageView(
                      controller: _pageController1,
                      onPageChanged: ((value) => _setPageIndex(value)),
                      children: [
                        HabitsPage(
                          checkBaxTapped: _checkBoxTapped,
                          editHabitForm: _editHabitForm,
                          deleteHabit: _deleteHabit,
                          onTap: _viewHabit,
                        ),
                        SizedBox(
                          /* height: (size.height -
                                  appbar.preferredSize.height -
                                  pad.top) *
                              0.92, */
                          child: HabitsAnalytics(
                            dataset: a.heatMapDataset,
                            startDate: _mybox2.get('START_DATE'),
                            onPressed: _openEndDrawer,
                          ),
                        )
                      ],
                    ),
                  ),
                  _pageIndex1 == 0
                      ? Positioned(
                          left: 0,
                          right: 20,
                          bottom: 10,
                          child: QuickShortcuts(
                            onAdd: () => _addNewHabit(context),
                            onClear: () => _clearHabits(context),
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
      endDrawer: const NavigationnDrawer(),
    );
  }

  //                                                            \\
  //                                                            \\
  //                                                            \\
  //       // >>>> OPENING BOTTOMSHETS AND DRAWERS <<<< \\      \\
  //                                                            \\
  //                                                            \\

  // Open scaffold end drawer
  void _openEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  // Confirm Clear of all habits
  void _clearHabits(BuildContext ctx) {
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

  // draw add new habit bottom sheet
  void _addNewHabit(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) => AddBottomSheetContent(addHabit: _addHabit),
    );
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

  // open habit bottomsheet
  void _viewHabit(BuildContext ctx, int habitIndex, String habit,
      bool hasCompleted, DateTime date) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) => ViewHabitBottomSheet(
        habitIndex: habitIndex,
        habit: habit,
        status: hasCompleted,
        date: date,
        deleteHabit: _deleteHabit,
      ),
    );
  }

  //                                                            \\
  //                                                            \\
  //                                                            \\
  //           // >>>> HABIT CRUD OPERATIONS <<<< \\            \\
  //                                                            \\
  //                                                            \\

  // checkBox Tapped
  void _checkBoxTapped(bool? value, index) {
    setState(() {
      a.habits[index][1] = value;
    });
    a.updateCurrentDb();
    a.streaks();
  }

  // Adding a new Habit
  void _addHabit(
      {required DateTime dateAdded,
      required String habit,
      required bool complited}) {
    final newHabit = [habit, complited, dateAdded];
    setState(() {
      a.habits.add(newHabit);
    });
    a.updateCurrentDb();
    a.streaks();
  }

  // Edit habit
  void _editHabit(int index) {
    setState(() {
      a.habits[index][0] = _controller.text.trim();
    });
    _controller.clear();
    Navigator.of(context).pop();
    a.updateCurrentDb();
    a.streaks();
  }

  // delete habit
  void _deleteHabit(int index) {
    setState(() {
      a.habits.removeAt([index][0]);
    });
    a.updateCurrentDb();
    a.streaks();
    Navigator.of(context).pop();
  }

  // delete all habit
  void _deleteAllHabits() {
    setState(() {
      a.habits.clear();
    });
    a.updateCurrentDb();
    a.streaks();
    Navigator.of(context).pop();
  }

  //        // >>>> ACCESSING MODELS AND DATABASE <<<< \\      \\
  /*                   */ final HabitDb a = HabitDb();
  /*                   */ final Analytics b = Analytics();
  /*                   */ final _mybox2 = Hive.box('Habit_Percent');

  //                                                            \\
  //                                                            \\
  //                                                            \\
  //       // >>>> OTHER METHODS CALLED ANONIMOUSLY <<<< \\     \\
  //                                                            \\
  //                                                            \\
}
