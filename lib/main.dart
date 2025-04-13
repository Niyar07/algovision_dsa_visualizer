import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/sorting_screen.dart';
import 'screens/stack_queue_screen.dart';
import 'screens/tree_screen.dart';

void main() {
  runApp(AlgoVisionApp());
}

class AlgoVisionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlgoVision - DSA Visualizer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/sorting': (context) => SortingScreen(),
        '/stackqueue': (context) => StackQueueScreen(),
        '/tree': (context) => TreeScreen(),
      },
    );
  }
}
