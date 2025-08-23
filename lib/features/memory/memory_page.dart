import 'package:flutter/material.dart';

class MemoryPage extends StatelessWidget {
  const MemoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('思い出'),
        backgroundColor: Colors.teal.shade50,
      ),
      body: const Center(
        child: Text(
          '思い出（仮）',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
