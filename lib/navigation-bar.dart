import 'package:flutter/material.dart';
import 'package:todo/main.dart';
import 'package:todo/all_tasks_screen.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromARGB(255, 35, 8, 78),
      selectedItemColor: Colors.white,
      unselectedItemColor: Color.fromARGB(255, 173, 158, 241),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.task_alt_rounded),
          label: 'All Tasks',
        ),
      ],
      onTap: (int index) {
        if (index == 0) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        } else if (index == 1) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => AllTaskScreen()),
          );
        }
      },
    );
  }
}
