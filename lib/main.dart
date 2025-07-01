// import 'package:flutter/material.dart';
// import 'screens/home_screen.dart';
// import 'screens/sorting_screen.dart';
// import 'screens/stack_queue_screen.dart';
// import 'screens/tree_screen.dart';

// void main() {
//   runApp(AlgoVisionApp());
// }

// class AlgoVisionApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'AlgoVision - DSA Visualizer',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.indigo,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => HomeScreen(),
//         '/sorting': (context) => SortingScreen(),
//         '/stackqueue': (context) => StackQueueScreen(),
//         '/tree': (context) => TreeScreen(),
//       },
//     );
//   }
// }

import 'package:algovision_dsa_visualizer/screens/onboarding.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages

void main() {
  runApp(DSAVisualizerApp());
}

class DSAVisualizerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DSA Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: OnboardingScreen(),
    );
  }
}
