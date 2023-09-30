import 'package:driving_korea/screens/quiz_pages/quiz_play.dart';
import 'package:driving_korea/screens/read_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          _buildDashboardItem(
            title: 'Reading',
            icon: Icons.book,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ReadScreen()));
            },
          ),
          _buildDashboardItem(
            title: 'Practice',
            icon: Icons.school,
            onTap: () {
              // Add functionality for the Practice section

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const QuizScreen()));
            },
          ),
          _buildDashboardItem(
            title: 'FAQ',
            icon: Icons.question_answer,
            onTap: () {
              // Add functionality for the FAQ section
            },
          ),
          _buildDashboardItem(
            title: 'About Us',
            icon: Icons.info,
            onTap: () {
              // Add functionality for the About Us section
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}
