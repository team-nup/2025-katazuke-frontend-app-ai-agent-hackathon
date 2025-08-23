import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム'),
        backgroundColor: Colors.teal.shade50,
      ),
      body: const Center(
        child: Text(
          'ホーム画面（仮）',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
