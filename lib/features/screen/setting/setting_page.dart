import 'package:flutter/material.dart';
import '../../components/app_bar.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(
        title: '設定',
        titleIcon: Icons.settings,
        showBackButton: true,
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
