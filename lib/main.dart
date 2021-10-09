import 'package:flutter/material.dart';
import 'package:tasks/screens/home_screen.dart';
import 'package:tasks/screens/list_screen.dart';
import 'package:tasks/screens/task_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasks',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      routes: {
        ListScreen.routeName: (ctx) => ListScreen(),
        TaskScreen.routeName: (ctx) => TaskScreen()
      },
    );
  }
}
