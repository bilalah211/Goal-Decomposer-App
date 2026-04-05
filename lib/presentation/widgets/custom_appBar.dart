import 'package:flutter/material.dart';
import 'package:goal_decomposer/core/theme/app_colors.dart';
import 'package:goal_decomposer/core/utils/app_textStyle.dart';
import 'package:goal_decomposer/core/utils/media_query_helper.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? action;
  final bool showBackButton;

  const MyAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: MediaQueryHelper.height(context) / 10,
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            showBackButton
                ? InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.primaryBlueColor,
                    ),
                  )
                : SizedBox(width: 50),
            SizedBox(width: 20),
            Text(title, style: AppTextStyles.appBarLabel),
            Spacer(),

            Row(children: action ?? [SizedBox(width: 50)]),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
