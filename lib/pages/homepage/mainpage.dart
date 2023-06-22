import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/homepage/widgets/floating_buttons.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/add_habit_dialog.dart';
import '../../components/edit_habit_dialog.dart';
import '../../components/habit_tile.dart';
import '../../data/habit_database.dart';
import '../bottomsheetpage/bottomsheetpage.dart';
import '../bottomsheetpage/editbottomsheet.dart';

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
  //final _pageController = PageController();

  // checkBox Tapped
  void checkBaxTapped(bool? value, index) {
    setState(() {
      a.habits[index][1] = value;
    });
    a.updateCurrentDb();
  }

  // delete habit
  void deleteHabit(int index) {
    setState(() {
      a.habits.removeAt([index][0]);
    });
    a.updateCurrentDb();
  }

  // Set page name
  void setPageName(int value) {
    setState(() {
      pageName = pageNames[value];
    });
  }

  // draw add new habit bottom sheet
  void _addHabitForm(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) => BottomSheetContent(addHabit: _addHabit),
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

  // cancel adding
  void onCancel() {
    Navigator.of(context).pop();
    _controller.clear();
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
                  Column(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.only(right: 8, left: 8, top: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              'assets/images/homegym.svg',
                              width: (size.width - 16) *
                                  0.5, // Adjust the width as needed
                              height: 120,
                              fit: BoxFit
                                  .fitWidth, // Adjust the height as needed
                            ),
                            SvgPicture.asset(
                              'assets/images/dogwalk.svg',
                              width: (size.width - 16) *
                                  0.5, // Adjust the width as needed
                              height: 120,
                              fit: BoxFit
                                  .fitWidth, // Adjust the height as needed
                            ),
                          ],
                        ),
                      ),
                      a.habits.isEmpty
                          ? Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 20.0, top: 30),
                                      child: Text(
                                        'No habits added yet!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      'assets/images/arrow.svg',
                                      height: 180,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.only(top: 20),
                                itemCount: a.habits.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      HabitTile(
                                        habitName: a.habits[index][0],
                                        habitCompleted: a.habits[index][1],
                                        onChanged: (value) =>
                                            checkBaxTapped(value, index),
                                        edit: (context) =>
                                            _editHabitForm(context, index),
                                        delete: (context) => deleteHabit(index),
                                      ),
                                      Divider(
                                        color: Theme.of(context).primaryColor,
                                        indent: 40,
                                      )
                                    ],
                                  );
                                },
                              ),
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
