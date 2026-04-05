import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/app_textStyle.dart';
import '../../core/utils/media_query_helper.dart';

class CustomOutlineButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback? onTap;
  final double? height;
  const CustomOutlineButton({
    super.key,
    required this.title,
    this.icon,
    this.onTap,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 35, color: AppColors.primaryBlueColor),
            SizedBox(width: 10),
            Text(
              title,
              style: AppTextStyles.labelMedium.copyWith(
                fontSize: 20,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
