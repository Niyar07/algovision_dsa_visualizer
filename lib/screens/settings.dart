import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
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
              // Apply dark mode (implement theme switch if needed)
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
              // Navigate to password change screen (not implemented here)
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
