import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/app_textStyle.dart';

class CustomRoundedContainer extends StatelessWidget {
  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final String buttonTitle;
  final Color color;
  final Color? textColor;
  final bool selectedIndex;
  final double? fontSize;
  final Widget? child;

  const CustomRoundedContainer({
    super.key,

    this.onTap,
    this.height,
    this.width,
    required this.buttonTitle,
    required this.color,
    this.textColor,
    this.selectedIndex = false,
    this.fontSize = 18,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: selectedIndex
              ? BoxBorder.all(color: AppColors.primaryBlueColor)
              : BoxBorder.all(color: Colors.grey.shade500),
        ),
        child: Center(
          child:
              child ??
              Text(
                buttonTitle,
                style: AppTextStyles.labelSmall.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                  color: textColor,
                ),
              ),
        ),
      ),
    );
  }
}
