import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationnDrawer extends StatefulWidget {
  const NavigationnDrawer({super.key});

  @override
  State<NavigationnDrawer> createState() => _NavigationnDrawerState();
}

class _NavigationnDrawerState extends State<NavigationnDrawer> {
  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsetsDirectional.only(top: 86),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                  ),
                  color: Color(0xffFFFFFF),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Text(
                            'Quick Tips Just For You',
                            style: GoogleFonts.montserrat(
                              fontSize: 17,
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              tips,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.hubballi(
                                color: const Color(0xff000000),
                                fontSize: 19,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        child: Image.asset(
                          'assets/images/homer.png',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  final String tips = '''
1. Keep a manageble list of habits, 10 Max

2. Let your habit be less that 25 character you dont wanna keep paragraph of text

3. Tap on habit to manage and view your overall streaks

4. You retain all the habits, the stronger the color becomes on the heatmap

5. Habit heatmap is powerful tool if you've been working on a consistent habit list.

🚫 If you clear all your habits you will lose all the data stored for that list of habits
  ''';
}
