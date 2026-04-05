import 'package:flutter/material.dart';
import 'package:goal_decomposer/presentation/widgets/custom_appBar.dart';
import 'package:provider/provider.dart';

import '../../core/utils/my_snackbar.dart';
import '../../core/utils/routes.dart';
import '../viewModel/goal_provider.dart';
import '../widgets/goal_card.dart';

class CompletedGoalView extends StatefulWidget {
  const CompletedGoalView({super.key});

  @override
  State<CompletedGoalView> createState() => _CompletedGoalViewState();
}

class _CompletedGoalViewState extends State<CompletedGoalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Completed Goals', showBackButton: true),
      body: Column(
        children: [
          Expanded(
            child: Consumer<GoalProvider>(
              builder: (context, vm, child) {
                if (vm.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (vm.goals.isEmpty) {
                  return const Center(child: Text("No Goals Found Yet"));
                }
                final completedGoal = vm.goals
                    .where((g) => g.progress >= 1.0)
                    .toList();
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ListView.builder(
                    itemCount: completedGoal.length,
                    itemBuilder: (context, index) {
                      final goal = completedGoal[index];
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.summary,
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
                                      vm.deleteGoal(
                                        vm.goals[index].id.toString(),
                                      );
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
