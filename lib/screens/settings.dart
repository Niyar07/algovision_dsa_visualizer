import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode =
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text("Dark Mode"),
            value: _darkMode,
            onChanged: (value) {
              setState(() => _darkMode = value);
              final themeMode = value ? ThemeMode.dark : ThemeMode.light;
              final appState =
                  context.findAncestorStateOfType<_ThemeWrapperState>();
              appState?.updateTheme(themeMode);
            },
          ),
          SwitchListTile(
            title: Text("Notifications"),
            value: _notifications,
            onChanged: (value) => setState(() => _notifications = value),
          ),
          ListTile(
            title: Text("Change Password"),
            trailing: Icon(Icons.lock),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Change Password"),
                  content: Text("Password change feature not implemented."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("OK"),
                    )
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: Text("Logout"),
            trailing: Icon(Icons.logout),
            onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }
}

/// Wrapper widget to handle theme switching globally
class ThemeWrapper extends StatefulWidget {
  final Widget child;
  ThemeWrapper({required this.child});

  @override
  _ThemeWrapperState createState() => _ThemeWrapperState();
}

class _ThemeWrapperState extends State<ThemeWrapper> {
  ThemeMode _themeMode = ThemeMode.system;

  void updateTheme(ThemeMode mode) {
    setState(() => _themeMode = mode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: widget.child,
    );
  }
}
