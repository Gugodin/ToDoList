import 'package:flutter/material.dart';
import 'package:todolist/pages/MainPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      debugShowCheckedModeBanner: false,
      initialRoute: "MainPage",
      routes: {
        "MainPage": (context) => const MainPage(),
      },
    );
  }
}
