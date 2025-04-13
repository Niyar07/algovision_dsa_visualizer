import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AlgoVision'),
        centerTitle: true,
        elevation: 4,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade100, Colors.indigo.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome to AlgoVision!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
                ),
              ),
              SizedBox(height: 30),
              AlgoButton(
                title: '🧮 Sorting Visualizer',
                onTap: () => Navigator.pushNamed(context, '/sorting'),
              ),
              SizedBox(height: 20),
              AlgoButton(
                title: '📦 Stack & Queue Simulator',
                onTap: () => Navigator.pushNamed(context, '/stackqueue'),
              ),
              SizedBox(height: 20),
              AlgoButton(
                title: '🌳 Tree Traversal Visualizer',
                onTap: () => Navigator.pushNamed(context, '/tree'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AlgoButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const AlgoButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Colors.white,
        foregroundColor: Colors.indigo.shade800,
        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(title),
    );
  }
}
