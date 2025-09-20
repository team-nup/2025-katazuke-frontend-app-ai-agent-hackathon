import 'package:flutter/material.dart';

class AgeUtils {
  static const List<Map<String, dynamic>> ageStages = [
    {'label': 'あかちゃん', 'icon': Icons.child_care, 'age': 2},
    {'label': '子供', 'icon': Icons.face, 'age': 8},
    {'label': '中学生', 'icon': Icons.person_outline, 'age': 14},
    {'label': '大学生', 'icon': Icons.school_outlined, 'age': 22},
    {'label': '社会人', 'icon': Icons.work, 'age': 30},
    {'label': '中年', 'icon': Icons.person, 'age': 60},
    {'label': 'シニア', 'icon': Icons.elderly, 'age': 80},
  ];

  /// 年齢からアイコンとラベルを取得する
  static Map<String, dynamic> getAgeStageInfo(int age) {
    for (int i = 0; i < ageStages.length; i++) {
      if (age <= ageStages[i]['age']) {
        return {
          'icon': ageStages[i]['icon'],
          'label': ageStages[i]['label'],
        };
      }
    }
    return {
      'icon': ageStages.last['icon'],
      'label': ageStages.last['label'],
    };
  }

  static bool isAgeInRange(int age, int? startAge, int? endAge) {
    if (startAge == null && endAge == null) return false;
    if (startAge != null && endAge != null) {
      return age >= startAge && age <= endAge;
    }
    if (startAge != null) return age == startAge;
    if (endAge != null) return age == endAge;
    return false;
  }

  static bool isAgeSelected(int age, int? startAge, int? endAge) {
    return age == startAge || age == endAge;
  }

  static bool isLineHighlighted(int index, int? startAge, int? endAge) {
    if (startAge == null || endAge == null) return false;
    final currentAge = ageStages[index]['age'] as int;
    final nextAge = ageStages[index + 1]['age'] as int;
    return currentAge >= startAge && nextAge <= endAge;
  }

  static void onStageSelected(
    int age,
    int? startAge,
    int? endAge,
    Function(String) onStartAgeChanged,
    Function(String) onEndAgeChanged,
  ) {
    if (startAge == null) {
      onStartAgeChanged(age.toString());
    } else if (endAge == null) {
      if (age >= startAge) {
        onEndAgeChanged(age.toString());
      } else {
        onStartAgeChanged(age.toString());
        onEndAgeChanged(startAge.toString());
      }
    } else {
      onStartAgeChanged(age.toString());
      onEndAgeChanged('');
    }
  }

  static void clearSelection(
    Function(String) onStartAgeChanged,
    Function(String) onEndAgeChanged,
  ) {
    onStartAgeChanged('');
    onEndAgeChanged('');
  }
}
