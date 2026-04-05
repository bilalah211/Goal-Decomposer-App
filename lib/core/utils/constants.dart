import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  ///---[AppBar Titles]---
  static const String addGoal = 'Add Goal';
  static const String summary = 'Tasks Summary';
  static const String completed = 'Goal Completed!';
  static const String goalDetails = 'Goal Details';

  ///---[Greetings Text]---
  static const String greetings = 'WELCOME!';
  static const String splash = 'Goal Decomposition';

  ///---[Hive Box]---
  static const String goalBoxName = 'goal_box';

  ///---[OpenRouter AI ApiKey]---
  static String apiKey = dotenv.env['OPEN_ROUTER_KEY'] ?? 'Key not found';
}
