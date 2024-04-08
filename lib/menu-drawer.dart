import 'package:flutter/widgets.dart';
import 'package:todo/main.dart';
import 'package:flutter/material.dart';
import 'package:todo/all_tasks_screen.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            color: Color.fromARGB(255, 35, 8, 78),
            height: 100,
            alignment: Alignment.centerLeft,
            child: Text(
              'Menu',
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_rounded),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MyApp()));
            },
          ),
          ListTile(
            leading: Icon(Icons.task_alt_rounded),
            title: Text(
              'All Tasks',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AllTaskScreen()));
            },
          ),
        ],
      ),
    );
  }
}
