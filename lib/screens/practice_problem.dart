import 'package:flutter/material.dart';

class PracticeProblemScreen extends StatelessWidget {
  final List<Map<String, String>> problems = [
    {
      'title': 'Two Sum',
      'difficulty': 'Easy',
      'description': 'Find two numbers that add up to a target.',
    },
    {
      'title': 'Merge Intervals',
      'difficulty': 'Medium',
      'description': 'Merge all overlapping intervals.',
    },
    {
      'title': 'LRU Cache',
      'difficulty': 'Hard',
      'description': 'Design a data structure for Least Recently Used cache.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Practice Problems')),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: problems.length,
        separatorBuilder: (_, __) => SizedBox(height: 12),
        itemBuilder: (context, index) {
          final problem = problems[index];
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: ListTile(
              title: Text(problem['title']!,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(problem['description']!),
              trailing: Chip(
                label: Text(problem['difficulty']!),
                backgroundColor: _getDifficultyColor(problem['difficulty']!),
              ),
              onTap: () {
                // Navigate to problem detail (future enhancement)
              },
            ),
          );
        },
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        return Colors.green.shade200;
      case 'Medium':
        return Colors.orange.shade200;
      case 'Hard':
        return Colors.red.shade200;
      default:
        return Colors.grey.shade300;
    }
  }
}
