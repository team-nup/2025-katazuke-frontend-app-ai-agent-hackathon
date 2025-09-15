import 'package:flutter/material.dart';
import 'package:okataduke/core/theme/app_colors.dart';

class AgeCard extends StatelessWidget {
  final int? startAge;
  final int? endAge;
  final Function(String) onStartAgeChanged;
  final Function(String) onEndAgeChanged;

  const AgeCard({
    super.key,
    this.startAge,
    this.endAge,
    required this.onStartAgeChanged,
    required this.onEndAgeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: AppColors.secondary.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              AppColors.surface,
              AppColors.secondaryLight.withOpacity(0.3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: AppColors.secondary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'いつ頃使ってた？',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'いつ頃の思い出ですか？（年齢）',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStyledTextField(
                    initialValue: startAge?.toString() ?? '',
                    labelText: '開始年齢',
                    hintText: '例：6',
                    icon: Icons.play_arrow,
                    keyboardType: TextInputType.number,
                    onChanged: onStartAgeChanged,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.arrow_forward,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStyledTextField(
                    initialValue: endAge?.toString() ?? '',
                    labelText: '終了年齢',
                    hintText: '例：12',
                    icon: Icons.stop,
                    keyboardType: TextInputType.number,
                    onChanged: onEndAgeChanged,
                  ),
                ),
              ],
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
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.card.withOpacity(0.5),
        border: Border.all(
          color: AppColors.secondary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: keyboardType,
        onChanged: onChanged,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          labelStyle: TextStyle(
            color: AppColors.secondary,
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
