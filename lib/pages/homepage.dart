import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/add_habit_dialog.dart';
import 'package:habit_tracker/components/edit_habit_dialog.dart';
import 'package:habit_tracker/components/monthly_analysis.dart';
import 'package:habit_tracker/data/habit_database.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HabitDb a = HabitDb();
  final _mybox = Hive.box('Habit_Database');

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

  String? errorText;

  // Habit name Text Controller
  final _controller = TextEditingController();
  // checkBox Tapped
  void checkBaxTapped(bool? value, index) {
    setState(() {
      a.habits[index][1] = value;
    });
    a.updateCurrentDb();
  }

  // create new habit
  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return NewHabitDialog(
          controller: _controller,
          onSave: onSave,
          onCancel: onCancel,
        );
      },
    );
  }

  // save new habit
  void onSave() {
    setState(() {
      a.habits.add([_controller.text.trim(), false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    a.updateCurrentDb();
  }

  // cancel adding
  void onCancel() {
    Navigator.of(context).pop();
    _controller.clear();
  }

  // delete habit
  void deleteHabit(int index) {
    setState(() {
      a.habits.removeAt([index][0]);
    });
    a.updateCurrentDb();
  }

  // Open habit setting
  void editHabit(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return EditDialog(
          controller: _controller,
          hintText: a.habits[index][0],
          onSave: () => onEdit(index),
          onCancel: onCancel,
        );
      },
    );
  }

  // edit existing habit
  void onEdit(int index) {
    setState(() {
      a.habits[index][0] = _controller.text;
    });
    _controller.clear();
    Navigator.of(context).pop();
    a.updateCurrentDb();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe8eeff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 20, left: 20.0),
              width: MediaQuery.of(context).size.width,
              height: 175,
              decoration: const BoxDecoration(
                color: Color.fromARGB(0, 44, 49, 64),
              ),
              child: Stack(
                children: [
                  Text(
                    'Your',
                    style: GoogleFonts.marcellus(
                      fontSize: 80,
                      color: const Color(0xff2c3140),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 16,
                    top: 85,
                    child: Text(
                      'Habit Tracker',
                      style: GoogleFonts.marcellus(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff2c3140),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: SizedBox(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      pageName,
                      style: GoogleFonts.shadowsIntoLightTwo(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2,
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: 2,
                      effect: const ExpandingDotsEffect(
                        dotWidth: 20,
                        activeDotColor: Color(0xffaabdf8),
                        dotColor: Color.fromRGBO(250, 250, 250, 0.855),
                        spacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 1,
            child: SizedBox(
              child: PageView(
                controller: _pageController,
                onPageChanged: ((value) => setPageName(value)),
                children: [
                  Stack(
                    children: [
                      ListView.builder(
                        itemCount: a.habits.length,
                        itemBuilder: (context, index) {
                          return HabitTile(
                            habitName: a.habits[index][0],
                            habitCompleted: a.habits[index][1],
                            onChanged: (value) => checkBaxTapped(value, index),
                            edit: (context) => editHabit(index),
                            delete: (context) => deleteHabit(index),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 10,
                        right: 0,
                        left: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 70,
                              width: 140,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(123, 131, 131, 131),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40),
                                ),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FloatingActionButton(
                                        onPressed: createNewHabit,
                                        shape: const CircleBorder(),
                                        backgroundColor:
                                            const Color(0xff2c3140),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                      FloatingActionButton(
                                        onPressed: _confirmClear,
                                        shape: const CircleBorder(),
                                        backgroundColor:
                                            const Color(0xff2c3140),
                                        child: const Icon(
                                          Icons.clear_all_outlined,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // heat map
                  MonthAnalysis(
                    dataset: a.heatMapDataset,
                    startDate: _mybox.get('START_DATE'),
                  ),
                ],
              ),
            ),
          ),
        ],
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
