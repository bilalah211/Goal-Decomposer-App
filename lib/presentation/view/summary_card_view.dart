import 'package:goal_decomposer/core/utils/constants.dart';
import 'package:goal_decomposer/presentation/widgets/custom_appBar.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/app_textStyle.dart';
import 'package:flutter/material.dart';

import '../../data/models/goal_model.dart';

class SummaryCardView extends StatelessWidget {
  final GoalCardModel goal;

  const SummaryCardView({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    final completedSteps =
        goal.tasks?.where((t) => t.isCompleted).toList() ?? [];

    return Scaffold(
      appBar: MyAppBar(showBackButton: true, title: AppConstants.summary),
      body: completedSteps.isEmpty
          ? const Center(child: Text("No steps completed yet!"))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListView.builder(
                itemCount: completedSteps.length,
                itemBuilder: (context, index) {
                  final task = completedSteps[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black12),
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
                                Icon(Icons.check_box, size: 20),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    task.title,
                                    softWrap: false,
                                    maxLines: 10,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.labelMedium.copyWith(
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
            ),
    );
  }
}
