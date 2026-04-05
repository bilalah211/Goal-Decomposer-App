import 'package:goal_decomposer/core/utils/constants.dart';
import 'package:goal_decomposer/data/models/goal_model.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/task_model.dart';

class HiveServices {
  static late Box<GoalCardModel>? goalBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(GoalCardModelAdapter());
    Hive.registerAdapter(TaskModelAdapter());
    // await Hive.deleteBoxFromDisk(AppConstants.goalBoxName);
    goalBox = await Hive.openBox<GoalCardModel>(AppConstants.goalBoxName);
  }
}
