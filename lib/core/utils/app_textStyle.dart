import 'package:flutter/material.dart';
import 'package:goal_decomposer/core/theme/app_colors.dart';

class AppTextStyles {
  static const TextStyle headerWhite = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteColor,
  );

  static const TextStyle goalTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textBlackPrimaryColor,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 20,
    color: AppColors.textSecondaryGreyColor,
    fontWeight: FontWeight.w800,
  );
  static const TextStyle labelSmall = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondaryGreyColor,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle appBarLabel = TextStyle(
    color: AppColors.primaryBlueColor,
    fontSize: 25,
    fontWeight: FontWeight.w800,
  );
}
