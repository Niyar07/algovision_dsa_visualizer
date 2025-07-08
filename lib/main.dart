import 'package:algovision_dsa_visualizer/screens/data_structure_detail.dart';
import 'package:algovision_dsa_visualizer/screens/home.dart';
import 'package:algovision_dsa_visualizer/screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:algovision_dsa_visualizer/widgets/app_theam.dart';
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
      theme: oceanTheme, // Apply the ocean theme here
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.light, // Use light mode with ocean theme
      // home: OnboardingScreen(),
      home: HomeScreen(),
    );
  }
}
