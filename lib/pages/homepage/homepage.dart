import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/homepage/widgets/heatmap_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/habit_database.dart';
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
  List<String> pageNames = [
    'Habit List',
    'Your Habit Analysis',
  ];
  String pageName = 'Habit List';
  late int widgetIndex = 0;
  final _pageController = PageController();

  // Set page name
  void setPageName(int value) {
    setState(() {
      pageName = pageNames[value];
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
      backgroundColor: const Color(0xff353535),
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height:
                  (size.height - appbar.preferredSize.height - pad.top) * 0.06,
              padding: const EdgeInsets.only(left: 40, bottom: 15),
              child: Row(
                children: <Widget>[
                  const Text(
                    "Habits",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0),
                  ),
                  Text(
                    ' Section',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            ),
            Container(
              height:
                  (size.height - appbar.preferredSize.height - pad.top) * 0.94,
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
                    children: [
                      HabitsPage(
                        checkBaxTapped: _checkBoxTapped,
                        editHabitForm: _editHabitForm,
                        deleteHabit: _deleteHabit,
                      ),
                      HeatMapAnalysis(
                        dataset: a.heatMapDataset,
                        startDate: _mybox.get('START_DATE'),
                      )
                    ],
                  ),
                  Positioned(
                    left: 0,
                    right: 20,
                    bottom: 10,
                    child: QuickShortcuts(
                      onAdd: () => _addHabitForm(context),
                      onClear: _confirmClear,
                      pageIndex: 0,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _confirmClear() async {
    switch (await showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Your Habits Tracker'),
            content: const Text('Are you sure you want to Clear Your Habits?'),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context, 'Yes');
                },
                child: const Text('Yes'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context, 'No');
                },
                child: const Text('No'),
              ),
            ],
          );
        })) {
      case 'Yes':
        setState(() {
          a.habits.clear();
        });
        a.updateCurrentDb();
        break;
      case 'No':
        break;
    }
  }
}
