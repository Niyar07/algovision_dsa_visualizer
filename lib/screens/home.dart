import 'package:flutter/material.dart';
import 'data_structure_detail.dart';
import 'algorithm_detail.dart';
import 'practice_problem.dart';
import 'leaderboard.dart';
import 'settings.dart';

class HomeScreen extends StatelessWidget {
  final List<_HomeOption> options = [
    _HomeOption(
      title: 'Data Structures',
      icon: Icons.storage,
      destination: DataStructureDetailScreen(),
      backgroundImage: Image.asset('assets/DSA.png', fit: BoxFit.cover),
    ),
    _HomeOption(
      title: 'Algorithms',
      icon: Icons.code,
      destination: AlgorithmDetailScreen(),
      backgroundImage: Image.asset('assets/Algorithms.png', fit: BoxFit.cover),
    ),
    _HomeOption(
      title: 'Settings',
      icon: Icons.settings,
      destination: SettingsScreen(),
      backgroundImage: Image.asset('assets/Settings.png', fit: BoxFit.cover),
    ),
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
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 1,
        padding: const EdgeInsets.all(60.0),
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
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
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.darken,
              ),
              child: option.backgroundImage,
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(option.icon, size: 48, color: Colors.white),
                  SizedBox(height: 16),
                  Text(
                    option.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeOption {
  final String title;
  final IconData icon;
  final Widget destination;
  final Image backgroundImage;

  _HomeOption({
    required this.title,
    required this.icon,
    required this.destination,
    required this.backgroundImage,
  });
}
