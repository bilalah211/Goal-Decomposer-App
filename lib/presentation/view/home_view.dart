import 'package:flutter/material.dart';
import 'package:goal_decomposer/core/theme/app_colors.dart';
import 'package:goal_decomposer/core/utils/appSizes.dart';
import 'package:goal_decomposer/core/utils/app_spacings.dart';
import 'package:goal_decomposer/core/utils/app_textStyle.dart';
import 'package:goal_decomposer/core/utils/constants.dart';
import 'package:goal_decomposer/core/utils/media_query_helper.dart';
import 'package:goal_decomposer/core/utils/my_snackbar.dart';
import 'package:goal_decomposer/data/models/goal_model.dart';
import 'package:goal_decomposer/presentation/viewModel/goal_provider.dart';
import 'package:goal_decomposer/presentation/widgets/my_custom_clipper.dart';
import 'package:provider/provider.dart';

import '../../core/utils/routes.dart';
import '../widgets/floating_action_button.dart';
import '../widgets/goal_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<GoalProvider>(context, listen: false).getAllGoals(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //---[Header Section]---
          _buildHeader(context),

          //---[Goal Card Section]---
          _buildGoalListView(),
        ],
      ),

      //---[Add Goal Button]---
      floatingActionButton: MyFloatingActionButton(
        title: AppConstants.addGoal,
        onPressed: () {
          Navigator.pushNamed(context, Routes.addGoal);
        },
      ),
    );
  }

  //---[Goal Card ListView Section]---

  Widget _buildGoalListView() {
    return Expanded(
      child: Consumer<GoalProvider>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.goals.isEmpty) {
            return const Center(child: Text("No Goals Found Yet"));
          }
          final inCompletedGoal = vm.goals
              .where((g) => g.progress < 1.0)
              .toList();
          return ListView.builder(
            itemCount: inCompletedGoal.length,
            itemBuilder: (context, index) {
              final goal = inCompletedGoal[index];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.goalDetails,
                    arguments: goal,
                  );
                },
                child: GoalCard(
                  donTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Delete Goal!'),
                        content: Text(
                          'This Action Will Permanently Delete Your Data!',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              vm.deleteGoal(vm.goals[index].id.toString());
                              mySnackBarMessenger(
                                context,
                                'Goal Deleted',
                                Icons.delete,
                                Colors.orangeAccent.shade400,
                                Colors.white,
                              );
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Yes',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  goalCard: goal,
                ),
              );
            },
          );
        },
      ),
    );
  }

  //---[Header Greetings Name Total Goals And Completed Goals Section]---
  Widget _buildHeader(BuildContext context) {
    final vm = Provider.of<GoalProvider>(context);
    final inCompletedGoal = vm.goals.where((g) => g.progress < 1.0).toList();
    return Container(
      height: MediaQueryHelper.height(context) / 4.5,
      width: MediaQueryHelper.width(context),
      decoration: BoxDecoration(color: AppColors.primaryBlueColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            //Greetings
            Positioned(
              left: 10,
              top: 40,
              child: _buildTextWidget(
                title: AppConstants.greetings,
                style: AppTextStyles.goalTitle.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
            ),

            //Settings Icon
            Positioned(
              right: 0,
              top: 40,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.settings);
                },
                child: Stack(
                  children: [
                    Icon(Icons.notifications, color: AppColors.whiteColor),
                    Positioned(
                      left: 3.5,
                      top: 2.5,
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Total Goal And Completed Goal Container
            Positioned(
              bottom: 0,

              left: 30,
              right: 35,
              child: Container(
                height: MediaQueryHelper.height(context) / 11,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusM),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTextWidget(
                            title: 'Total Goals',
                            style: AppTextStyles.labelSmall,
                          ),
                          _buildTextWidget(
                            title: inCompletedGoal.length.toString(),
                            style: AppTextStyles.labelMedium,
                          ),
                        ],
                      ),
                      Spacer(),
                      VerticalDivider(endIndent: 15, indent: 15),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.completedScreen);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildTextWidget(
                              title: 'Completed Goals',
                              style: AppTextStyles.labelSmall,
                            ),
                            _buildTextWidget(
                              title: vm.completedGoalsCount.toString(),
                              style: AppTextStyles.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //---[Text Widget]---
  Widget _buildTextWidget({required String title, required TextStyle style}) =>
      Text(title, style: style);
}
