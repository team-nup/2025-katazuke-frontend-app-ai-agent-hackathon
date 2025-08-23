import 'package:flutter/material.dart';

class AssessmentPage extends StatelessWidget {
  const AssessmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('価値検索'),
        backgroundColor: Colors.teal.shade50,
      ),
      body: const Center(
        child: Text(
          '価値検索（仮）',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
