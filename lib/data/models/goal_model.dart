import 'package:flutter/material.dart';
import 'package:goal_decomposer/core/theme/app_colors.dart';
import 'package:goal_decomposer/data/models/task_model.dart';
import 'package:hive/hive.dart';

part 'goal_model.g.dart';

@HiveType(typeId: 0)
class GoalCardModel extends HiveObject {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final DateTime deadline;
  @HiveField(4)
  final String priority;
  @HiveField(5)
  final int? colorValue;
  @HiveField(6)
  final List<TaskModel>? tasks;

  GoalCardModel({
    this.id,
    required this.title,
    required this.description,
    required this.deadline,
    required this.priority,
    this.colorValue,
    this.tasks,
  });

  //Color getter
  Color get color => Color(colorValue ?? 0xFF2196F3);

  //ColorValue getter

  Color get priorityColor {
    switch (priority) {
      case 'Low':
        return Colors.grey;
      case 'Medium':
        return Colors.green.shade400;
      case 'High':
        return Colors.red.shade400;
      default:
        return Colors.grey;
    }
  }

  //Progress getter
  double get progress {
    if (tasks == null || tasks!.isEmpty) return 0.0;
    final completedCount = tasks!.where((task) => task.isCompleted).length;

    return completedCount / tasks!.length;
  }

  //progress Color Getter

  Color get progressColor {
    final p = progress;

    if (p >= 1) {
      return Colors.green;
    } else if (p >= 0.5) {
      return AppColors.primaryBlueColor;
    } else {
      return Colors.orange.shade400;
    }
  }
}
