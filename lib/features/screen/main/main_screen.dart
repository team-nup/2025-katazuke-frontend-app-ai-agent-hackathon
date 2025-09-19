import 'package:flutter/material.dart';
import 'package:okataduke/core/theme/app_colors.dart';
import 'package:okataduke/features/screen/value_search/containers/value_search_create_container.dart';
import 'package:okataduke/features/screen/value_view/containers/value_list_container.dart';
import 'package:okataduke/features/screen/home/containers/home_container.dart';
import 'package:okataduke/features/screen/memory_view/containers/memory_list_container.dart';
import 'package:okataduke/features/screen/memory_record/containers/record_create_container.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 2;

  List<Widget> get _pages => [
        const MemoryListContainer(),
        RecordCreateContainer(
          onSaved: () => setState(() => _currentIndex = 0),
        ),
        const HomeContainer(),
        ValueSearchCreateContainer(
          onSaved: () => setState(() => _currentIndex = 4),
        ),
        const ValueListContainer(),
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
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '思い出',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: '思い出記録',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '価値検索',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: '売却管理',
          ),
        ],
      ),
    );
  }
}
