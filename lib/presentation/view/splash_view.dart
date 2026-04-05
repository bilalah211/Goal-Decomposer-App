import 'package:flutter/material.dart';
import 'package:goal_decomposer/core/theme/app_colors.dart';
import 'package:goal_decomposer/core/utils/app_assets.dart';
import 'package:goal_decomposer/core/utils/app_textStyle.dart';
import 'package:goal_decomposer/core/utils/constants.dart';
import 'package:goal_decomposer/core/utils/media_query_helper.dart';

import '../../core/utils/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, Routes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQueryHelper.height(context),
        width: MediaQueryHelper.width(context),
        decoration: BoxDecoration(color: AppColors.primaryBlueColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset(AppAssets.rocket, height: 300),
                Positioned(
                  left: 85,
                  top: 240,
                  child: Text(
                    AppConstants.splash,
                    style: AppTextStyles.labelMedium.copyWith(fontSize: 24),
                  ),
                ),
              ],
            ),
            CircularProgressIndicator(color: AppColors.whiteColor),
          ],
        ),
      ),
    );
  }
}
