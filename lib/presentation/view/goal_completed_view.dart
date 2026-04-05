import 'package:flutter/material.dart';
import 'package:goal_decomposer/core/theme/app_colors.dart';
import 'package:goal_decomposer/core/utils/app_assets.dart';
import 'package:goal_decomposer/core/utils/app_textStyle.dart';
import 'package:goal_decomposer/core/utils/constants.dart';
import 'package:goal_decomposer/core/utils/media_query_helper.dart';
import 'package:goal_decomposer/presentation/widgets/custom_appBar.dart';
import 'package:goal_decomposer/presentation/widgets/custom_rounded_button.dart';

import '../../core/utils/routes.dart';
import '../../data/models/goal_model.dart';
import '../widgets/my_custom_clipper.dart';

class GoalCompletedView extends StatefulWidget {
  final GoalCardModel goal;
  const GoalCompletedView({super.key, required this.goal});

  @override
  State<GoalCompletedView> createState() => _GoalCompletedViewState();
}

class _GoalCompletedViewState extends State<GoalCompletedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(showBackButton: true, title: AppConstants.completed),
      body: Column(
        children: [
          ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              height: 250,
              width: double.infinity,
              color: Colors.blue[700],
              child: Stack(
                children: [
                  Center(child: Image.asset(AppAssets.trophy, height: 250)),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),

          Center(
            child: Text(
              "Congratulations! You've \n achieved your goal!",
              textAlign: TextAlign.center,
              style: AppTextStyles.labelMedium.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
          ),
          SizedBox(height: 30),
          CustomRoundedContainer(
            height: MediaQueryHelper.height(context) / 17,
            width: MediaQueryHelper.width(context) / 1.2,
            buttonTitle: 'View Summary',
            color: AppColors.primaryBlueColor,
            onTap: () {
              Navigator.popAndPushNamed(
                context,
                Routes.summary,
                arguments: widget.goal,
              );
            },
          ),
        ],
      ),
    );
  }
}
