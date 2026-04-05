import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/app_textStyle.dart';
import '../../data/models/goal_model.dart';

class CircularProgress extends StatelessWidget {
  const CircularProgress({super.key, required this.goalCard});

  final GoalCardModel goalCard;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 70,
          width: 70,
          child: CircularProgressIndicator(
            value: goalCard.progress ?? 0.0,
            strokeWidth: 4,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(goalCard.progressColor),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              '${((goalCard.progress ?? 0.0) * 100).toInt()}%',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.primaryBlueColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
