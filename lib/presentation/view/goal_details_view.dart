import 'package:flutter/material.dart';
import 'package:goal_decomposer/core/theme/app_colors.dart';
import 'package:goal_decomposer/core/theme/priority_color_helper.dart';
import 'package:goal_decomposer/core/utils/app_textStyle.dart';
import 'package:goal_decomposer/core/utils/dateTime_helper.dart';
import 'package:goal_decomposer/core/utils/media_query_helper.dart';
import 'package:goal_decomposer/core/utils/my_snackbar.dart';
import 'package:goal_decomposer/core/utils/routes.dart';
import 'package:goal_decomposer/data/models/goal_model.dart';
import 'package:goal_decomposer/presentation/viewModel/goal_provider.dart';
import 'package:goal_decomposer/presentation/widgets/custom_appBar.dart';
import 'package:goal_decomposer/presentation/widgets/custom_rounded_button.dart';
import 'package:goal_decomposer/presentation/widgets/goal_card.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_outline_button.dart';

class GoalDetailsView extends StatefulWidget {
  final GoalCardModel goalCard;

  const GoalDetailsView({super.key, required this.goalCard});

  @override
  State<GoalDetailsView> createState() => _GoalDetailsViewState();
}

class _GoalDetailsViewState extends State<GoalDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar
      appBar: MyAppBar(
        showBackButton: true,
        title: widget.goalCard.title,
        action: [
          InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              Routes.summary,
              arguments: widget.goalCard,
            ),
            child: Icon(Icons.event_note_outlined, color: Colors.orangeAccent),
          ),
          SizedBox(width: 5),
          Icon(Icons.settings, color: AppColors.primaryBlueColor),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),

        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Deadline: ',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                ),

                Text(
                  dateAndTimeFormatted(widget.goalCard.deadline),
                  style: AppTextStyles.labelMedium.copyWith(
                    color: Colors.grey,

                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Priority:  ',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: Colors.black54,

                    fontSize: 18,
                  ),
                ),
                Text(
                  widget.goalCard.priority,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: widget.goalCard.priorityColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            Consumer<GoalProvider>(
              builder: (context, vm, child) {
                final goal = vm.goals.firstWhere(
                  (g) => g.id == widget.goalCard.id,
                );
                return GoalCard(goalCard: goal, isDeletedIcon: false);
              },
            ),
            SizedBox(height: 20),

            Consumer<GoalProvider>(
              builder: (context, vm, child) {
                final goal = vm.goals.firstWhere(
                  (g) => g.id == widget.goalCard.id,
                );

                return Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: goal.tasks!.length,
                    itemBuilder: (context, index) {
                      final task = goal.tasks![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        vm.toggleTask(goal.id!, index);
                                      },
                                      child: task.isCompleted
                                          ? Icon(Icons.check_box, size: 20)
                                          : Icon(
                                              Icons.check_box_outline_blank,
                                              size: 20,
                                            ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        task.title,
                                        softWrap: false,
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.labelMedium
                                            .copyWith(
                                              color: Colors.black54,
                                              fontSize: 16,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),

            SizedBox(height: 20),

            // CustomOutlineButton(
            //   height: MediaQueryHelper.height(context) / 17,
            //
            //   title: 'Add Subtask',
            //   icon: Icons.add,
            //   onTap: () {
            //     Navigator.pushNamed(context, Routes.addGoal);
            //   },
            // ),
            // SizedBox(height: 20),
            //
            // CustomRoundedContainer(
            //   height: MediaQueryHelper.height(context) / 17,
            //   width: MediaQueryHelper.width(context),
            //
            //   buttonTitle: 'Regenerate Steps',
            //   color: AppColors.primaryBlueColor,
            // ),
            // SizedBox(height: 20),
            CustomRoundedContainer(
              height: MediaQueryHelper.height(context) / 17,
              width: MediaQueryHelper.width(context),

              buttonTitle: 'Save',
              color: AppColors.primaryBlueColor,
              onTap: () {
                final vm = Provider.of<GoalProvider>(context, listen: false);
                final currentGoal = vm.goals.firstWhere(
                  (g) => g.id == widget.goalCard.id,
                );
                if (currentGoal.progress < 1.0) {
                  mySnackBarMessenger(
                    context,
                    'Complete Your Steps First',
                    Icons.warning,
                    Colors.orange.shade400,
                    Colors.white,
                  );
                } else {
                  mySnackBarMessenger(
                    context,
                    'Congratulations! Steps Completed',
                    Icons.check_circle,
                    Colors.green,
                    Colors.white,
                  );

                  vm.getAllGoals();

                  // Navigate to Completed Screen
                  Navigator.popAndPushNamed(
                    context,
                    Routes.completed,
                    arguments: currentGoal,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
