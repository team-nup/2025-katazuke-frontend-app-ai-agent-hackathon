import 'package:flutter/material.dart';
import 'package:okataduke/core/theme/app_colors.dart';

class BasicInfoCard extends StatelessWidget {
  final String title;
  final String? detail;
  final Function(String) onTitleChanged;
  final Function(String) onDetailChanged;

  const BasicInfoCard({
    super.key,
    required this.title,
    this.detail,
    required this.onTitleChanged,
    required this.onDetailChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.surface,
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.edit,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'どんな思い出？',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildStyledTextField(
              initialValue: title,
              labelText: 'タイトル',
              hintText: '例：小学生の時のランドセル',
              icon: Icons.title,
              onChanged: onTitleChanged,
            ),
            const SizedBox(height: 16),
            _buildStyledTextField(
              initialValue: detail ?? '',
              labelText: '詳細・思い出',
              hintText: 'この品物にまつわる思い出やエピソードを書いてください',
              icon: Icons.description,
              maxLines: 3,
              onChanged: onDetailChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStyledTextField({
    required String initialValue,
    required String labelText,
    required String hintText,
    required IconData icon,
    required Function(String) onChanged,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.card.withOpacity(0.5),
        border: Border.all(
          color: AppColors.textDisabled.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: keyboardType,
        maxLines: maxLines,
        onChanged: onChanged,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          labelStyle: TextStyle(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
          hintStyle: TextStyle(
            color: AppColors.textDisabled,
            fontSize: 14,
          ),
          prefixIcon: Icon(
            icon,
            color: AppColors.iconGreen,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
