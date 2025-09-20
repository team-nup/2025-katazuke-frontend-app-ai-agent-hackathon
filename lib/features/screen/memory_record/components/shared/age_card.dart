import 'package:flutter/material.dart';
import 'package:okataduke/core/theme/app_colors.dart';
import '../../../../utils/age_utils.dart';

class AgeCard extends StatefulWidget {
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
  State<AgeCard> createState() => _AgeCardState();
}

class _AgeCardState extends State<AgeCard> {
  late ScrollController _scrollController;
  late TextEditingController _startAgeController;
  late TextEditingController _endAgeController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startAgeController = TextEditingController(
      text: widget.startAge?.toString() ?? '',
    );
    _endAgeController = TextEditingController(
      text: widget.endAge?.toString() ?? '',
    );
  }

  @override
  void didUpdateWidget(AgeCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // アイコン選択による値の変更を検知して更新
    if (oldWidget.startAge != widget.startAge) {
      final newText = widget.startAge?.toString() ?? '';
      if (_startAgeController.text != newText) {
        _startAgeController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length),
        );
      }
    }
    if (oldWidget.endAge != widget.endAge) {
      final newText = widget.endAge?.toString() ?? '';
      if (_endAgeController.text != newText) {
        _endAgeController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length),
        );
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _startAgeController.dispose();
    _endAgeController.dispose();
    super.dispose();
  }

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
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'いつ頃使ってた？',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        fontSize: 20,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'いつ頃の思い出ですか？',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            _buildAgeTimeline(),
            const SizedBox(height: 16),
            _buildSelectedAgeDisplay(),
            const SizedBox(height: 20),
            _buildAgeInputFields(),
          ],
        ),
      ),
    );
  }

  Widget _buildAgeTimeline() {
    return Container(
      height: 95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.card.withOpacity(0.1),
      ),
      child: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: AgeUtils.ageStages.asMap().entries.map((entry) {
              final index = entry.key;
              final stage = entry.value;
              final age = stage['age'] as int;
              final isInRange = AgeUtils.isAgeInRange(
                  age, widget.startAge, widget.endAge);
              final isSelected = AgeUtils.isAgeSelected(
                  age, widget.startAge, widget.endAge);

              return Row(
                children: [
                  GestureDetector(
                    onTap: () => AgeUtils.onStageSelected(
                      age,
                      widget.startAge,
                      widget.endAge,
                      widget.onStartAgeChanged,
                      widget.onEndAgeChanged,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected
                                ? AppColors.primary
                                : isInRange
                                    ? AppColors.primary.withOpacity(0.3)
                                    : AppColors.card,
                            border: Border.all(
                              color: isInRange
                                  ? AppColors.primary
                                  : AppColors.textDisabled.withOpacity(0.3),
                              width: 2,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppColors.primary.withOpacity(0.3),
                                      blurRadius: 6,
                                      spreadRadius: 1,
                                    ),
                                  ]
                                : null,
                          ),
                          child: Icon(
                            stage['icon'] as IconData,
                            size: 20,
                            color: isSelected
                                ? Colors.white
                                : isInRange
                                    ? AppColors.primary
                                    : AppColors.textDisabled,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          stage['label'] as String,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: isInRange
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (index < AgeUtils.ageStages.length - 1)
                    Container(
                      width: 30,
                      height: 2,
                      margin: const EdgeInsets.only(bottom: 16),
                      color: AgeUtils.isLineHighlighted(
                              index, widget.startAge, widget.endAge)
                          ? AppColors.primary
                          : AppColors.textDisabled.withOpacity(0.3),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildAgeInputFields() {
    return Row(
      children: [
        Flexible(
          child: _buildStyledTextField(
            controller: _startAgeController,
            labelText: '開始年齢',
            hintText: '例：6',
            icon: Icons.play_arrow,
            keyboardType: TextInputType.number,
            onChanged: widget.onStartAgeChanged,
          ),
        ),
        const SizedBox(width: 12),
        Icon(
          Icons.arrow_forward,
          color: AppColors.textSecondary,
          size: 20,
        ),
        const SizedBox(width: 12),
        Flexible(
          child: _buildStyledTextField(
            controller: _endAgeController,
            labelText: '終了年齢',
            hintText: '例：12',
            icon: Icons.stop,
            keyboardType: TextInputType.number,
            onChanged: widget.onEndAgeChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildStyledTextField({
    required TextEditingController controller,
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
          color: AppColors.textDisabled.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
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

  Widget _buildSelectedAgeDisplay() {
    if (widget.startAge == null && widget.endAge == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.card.withOpacity(0.3),
          border: Border.all(
            color: AppColors.textDisabled.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.touch_app,
              color: AppColors.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              'アイコンをタップ',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primary.withOpacity(0.1),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.schedule,
            color: AppColors.primary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.startAge != null && widget.endAge != null
                  ? '${widget.startAge}歳 〜 ${widget.endAge}歳の思い出'
                  : widget.startAge != null
                      ? '${widget.startAge}歳頃の思い出'
                      : '${widget.endAge}歳頃の思い出',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => AgeUtils.clearSelection(
              widget.onStartAgeChanged,
              widget.onEndAgeChanged,
            ),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.2),
              ),
              child: Icon(
                Icons.clear,
                size: 16,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
