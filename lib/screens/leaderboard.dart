import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> leaders = [
    {'name': 'Alice', 'score': 980},
    {'name': 'Bob', 'score': 870},
    {'name': 'Charlie', 'score': 830},
    {'name': 'Diana', 'score': 790},
    {'name': 'Eve', 'score': 750},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leaderboard')),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: leaders.length,
        itemBuilder: (context, index) {
          final leader = leaders[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child:
                    Text('${index + 1}', style: TextStyle(color: Colors.white)),
              ),
              title: Text(leader['name'],
                  style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Text('Score: ${leader['score']}',
                  style: TextStyle(fontSize: 16)),
            ),
          );
        },
      ),
    );
  }
}
