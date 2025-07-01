import 'package:flutter/material.dart';

class AlgorithmDetailScreen extends StatefulWidget {
  @override
  _AlgorithmDetailScreenState createState() => _AlgorithmDetailScreenState();
}

class _AlgorithmDetailScreenState extends State<AlgorithmDetailScreen> {
  final List<String> algorithms = [
    'Bubble Sort',
    'Selection Sort',
    'Insertion Sort',
    'Merge Sort',
    'Quick Sort',
    'Binary Search',
    'DFS',
    'BFS'
  ];

  String selectedAlgorithm = 'Bubble Sort';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Algorithms')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: DropdownButton<String>(
              value: selectedAlgorithm,
              onChanged: (value) => setState(() => selectedAlgorithm = value!),
              items: algorithms
                  .map((algo) =>
                      DropdownMenuItem(value: algo, child: Text(algo)))
                  .toList(),
              isExpanded: true,
            ),
          ),
          Expanded(
            child: Card(
              margin: EdgeInsets.all(16),
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$selectedAlgorithm Visualizer',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12),
                    Expanded(
                      child: Container(
                        color: Colors.grey[200],
                        child: Center(
                            child:
                                Text("[Algorithm Visual Canvas Placeholder]")),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Run Algorithm'),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
