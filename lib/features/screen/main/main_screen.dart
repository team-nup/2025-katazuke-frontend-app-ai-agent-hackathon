import 'package:flutter/material.dart';
import 'package:okataduke/features/screen/value_search/containers/value_search_create_container.dart';
import 'package:okataduke/features/screen/home/containers/home_container.dart';
import 'package:okataduke/features/screen/memory/containers/memory_container.dart';
import 'package:okataduke/features/screen/memory_record/containers/record_create_container.dart';
import 'package:okataduke/features/screen/setting/setting_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContainer(),
    const MemoryContainer(),
    const RecordCreateContainer(),
    const ValueSearchCreateContainer(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.teal.shade700,
        unselectedItemColor: Colors.grey.shade600,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: '思い出',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: '記録',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: '価値検索',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '設定',
          ),
        ],
      ),
    );
  }
}
