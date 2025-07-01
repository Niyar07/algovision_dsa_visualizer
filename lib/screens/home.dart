// 📄 home.dart
import 'package:flutter/material.dart';
import 'data_structure_detail.dart';
import 'algorithm_detail.dart';
import 'practice_problem.dart';
import 'leaderboard.dart';
import 'settings.dart';

class HomeScreen extends StatelessWidget {
  final List<_HomeOption> options = [
    _HomeOption('Data Structures', Icons.storage, DataStructureDetailScreen()),
    _HomeOption('Algorithms', Icons.code, AlgorithmDetailScreen()),
    _HomeOption('Practice Problems', Icons.assignment, PracticeProblemScreen()),
    _HomeOption('Leaderboard', Icons.leaderboard, LeaderboardScreen()),
    _HomeOption('Settings', Icons.settings, SettingsScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DSA Visualizer'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
        padding: const EdgeInsets.all(16.0),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: options.map((option) => _buildCard(context, option)).toList(),
      ),
    );
  }

  Widget _buildCard(BuildContext context, _HomeOption option) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => option.destination),
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(option.icon,
                  size: 48, color: Theme.of(context).primaryColor),
              SizedBox(height: 16),
              Text(option.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeOption {
  final String title;
  final IconData icon;
  final Widget destination;

  _HomeOption(this.title, this.icon, this.destination);
}
