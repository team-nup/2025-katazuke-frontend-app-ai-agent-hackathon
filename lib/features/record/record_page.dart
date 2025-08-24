import 'package:flutter/material.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('記録'),
        backgroundColor: Colors.teal.shade50,
      ),
      body: const Center(
        child: Text(
          '記録（仮）',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
