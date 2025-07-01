import 'package:flutter/material.dart';
import 'login.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          _buildPage(
            context,
            "assets/welcome.svg",
            "Welcome to DSA Visualizer",
            "Understand data structures like never before!",
          ),
          _buildPage(
            context,
            "assets/learn.svg",
            "Learn & Interact",
            "Practice with live animations and code.",
          ),
          _buildPage(
            context,
            "assets/start.svg",
            "Let’s Get Started!",
            "Login to begin your DSA journey.",
            showButton: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPage(
      BuildContext context, String image, String title, String subtitle,
      {bool showButton = false}) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(image),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text(
            subtitle,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          if (showButton)
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                  );
                },
                child: Text("Login"),
              ),
            ),
        ],
      ),
    );
  }
}
