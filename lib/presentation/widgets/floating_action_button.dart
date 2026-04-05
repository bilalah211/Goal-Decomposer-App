import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/app_textStyle.dart';
import '../../core/utils/routes.dart';

class MyFloatingActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const MyFloatingActionButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: AppColors.primaryBlueColor,
      extendedIconLabelSpacing: 10,
      extendedPadding: EdgeInsets.symmetric(horizontal: 40),
      label: Text(
        title,
        style: AppTextStyles.labelSmall.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      icon: Icon(
        Icons.add,
        color: AppColors.whiteColor,
        fontWeight: FontWeight.bold,
        size: 30,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      onPressed: onPressed,
    );
  }
}
