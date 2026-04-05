import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goal_decomposer/data/models/goal_model.dart';
import 'package:goal_decomposer/data/models/task_model.dart';
import 'package:goal_decomposer/data/services/hive_services.dart';
import 'package:goal_decomposer/data/services/openRouterAI_services.dart';

import '../../data/services/local_notification_services.dart';

class GoalProvider with ChangeNotifier {
  final box = HiveServices.goalBox;
  final OpenRouterAIServices _openRouterAIServices = OpenRouterAIServices();

  //---[Variables]---
  //Date
  DateTime? selectedDate;
  String formattedDate = '';
  int? finalColor;

  //Goal
  List<GoalCardModel> _goals = [];

  List<GoalCardModel> get goals => _goals;

  int get completedGoalsCount {
    return _goals.where((goal) => goal.progress == 1.0).length;
  }

  //Loading Getter
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  //Loading Setter
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //---[Date Picker]---
  Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      selectedDate = pickedDate;
      formattedDate =
          '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
      notifyListeners();
    }
  }

  //---[Get All Goals]---
  void getAllGoals() {
    _goals = box!.values.toList();

    notifyListeners();
  }

  //---[Add And Generate Gaol Steps]---
  void addAndGenerateGoalSteps(GoalCardModel goal) async {
    try {
      _setLoading(true);
      notifyListeners();
      final aiText = await _openRouterAIServices.generateGoalAi(
        goal.title,
        goal.description,
      );

      final List<TaskModel> aiSteps = aiText
          .map((taskItem) => TaskModel(title: taskItem, isCompleted: false))
          .toList();

      final updatedGoal = GoalCardModel(
        id: goal.id,
        title: goal.title,
        description: goal.description,
        deadline: goal.deadline,
        priority: goal.priority,
        colorValue: goal.colorValue,
        tasks: aiSteps,
      );
      await box!.put(goal.id, updatedGoal);
      if (updatedGoal.deadline != null) {
        LocalNotificationServices.scheduleDeadlineNotification(
          id: goal.id.hashCode,
          title: updatedGoal.title,
          deadline: updatedGoal.deadline,
        );
      }
      _setLoading(false);
      notifyListeners();

      getAllGoals();
    } catch (e) {
      if (kDebugMode) {
        print('Error: ${e.toString()}');
      }
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  //---[Delete Goal]---
  void deleteGoal(String id) async {
    try {
      await box!.delete(id);
      getAllGoals();

      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error While Deleting goal:${e.toString()}');
      }
    }
  }

  //---[Toggle Goal]---
  void toggleTask(String goalId, int taskIndex) async {
    final index = _goals.indexWhere((g) => g.id == goalId);
    if (index != -1) {
      _goals[index].tasks![taskIndex].isCompleted =
          !_goals[index].tasks![taskIndex].isCompleted;

      // Save to Hive
      await _goals[index].save();

      notifyListeners();
    }
  }
}
