import 'package:algovision_dsa_visualizer/screens/data_structure_detail.dart';
import 'package:algovision_dsa_visualizer/screens/home.dart';
import 'package:algovision_dsa_visualizer/screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:algovision_dsa_visualizer/widgets/app_theam.dart';

import 'package:flutter/material.dart';
import 'package:algovision_dsa_visualizer/screens/home.dart';
import 'package:algovision_dsa_visualizer/screens/onboarding.dart';
import 'package:algovision_dsa_visualizer/widgets/app_theam.dart';
// ignore: depend_on_referenced_packages

// void main() {
//   runApp(DSAVisualizerApp());
// }

// class DSAVisualizerApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'DSA Visualizer',
//       theme: oceanTheme, // Apply the ocean theme here
//       darkTheme: ThemeData(
//         brightness: Brightness.dark,
//       ),
//       themeMode: ThemeMode.light, // Use light mode with ocean theme
//       // home: OnboardingScreen(),
//       home: HomeScreen(),
//     );
//   }
// }

void main() {
  runApp(DSAVisualizerApp());
}

class DSAVisualizerApp extends StatefulWidget {
  @override
  _DSAVisualizerAppState createState() => _DSAVisualizerAppState();
}

class _DSAVisualizerAppState extends State<DSAVisualizerApp> {
  // Default theme - using enhanced Ocean theme
  ThemeData _currentTheme = DSAThemes.oceanTheme;
  String _currentThemeName = 'Ocean';

  // Theme change handler
  void _changeTheme(ThemeData newTheme, String themeName) {
    setState(() {
      _currentTheme = newTheme;
      _currentThemeName = themeName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AlgoVision DSA Visualizer',

      // Enhanced theme system
      theme: _currentTheme,

      // Dark theme fallback (using Midnight theme)
      darkTheme: DSAThemes.midnightTheme,

      // Theme mode - you can change this to ThemeMode.system for automatic switching
      themeMode: ThemeMode.light,

      // Home screen with theme change callback
      home: HomeScreen(
        onThemeChanged: _changeTheme,
        currentThemeName: _currentThemeName,
      ),

      // Alternative: Uncomment below to start with onboarding
      // home: OnboardingScreen(
      //   onComplete: () => Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(
      //       builder: (context) => HomeScreen(
      //         onThemeChanged: _changeTheme,
      //         currentThemeName: _currentThemeName,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
