import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
        backgroundColor: Colors.teal.shade50,
      ),
      body: const Center(
        child: Text(
          '設定（仮）',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
