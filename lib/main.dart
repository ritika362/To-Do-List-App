import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:todo/menu-drawer.dart';
import 'package:todo/navigation-bar.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO App',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 35, 8, 78),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 35, 8, 78),
          actions: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Icon(
                Icons.task_alt_rounded,
              ),
            )
          ],
          iconTheme: IconThemeData(color: Colors.white),
        ),
        drawer: MenuDrawer(),
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 250, 0, 250),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'to',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'TODO App',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
