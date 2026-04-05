import 'package:flutter/material.dart';
import 'package:goal_decomposer/data/models/goal_model.dart';
import 'package:goal_decomposer/presentation/view/add_goal.dart';
import 'package:goal_decomposer/presentation/view/completed_goal_view.dart';
import 'package:goal_decomposer/presentation/view/goal_completed_view.dart';
import 'package:goal_decomposer/presentation/view/goal_details_view.dart';
import 'package:goal_decomposer/presentation/view/home_view.dart';
import 'package:goal_decomposer/presentation/view/splash_view.dart';
import 'package:goal_decomposer/presentation/view/summary_card_view.dart';

class Routes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String homeDetails = '/homeDetails';
  static const String goalDetails = '/goal';
  static const String addGoal = '/addGoal';
  static const String completed = '/completed';
  static const String completedScreen = '/completedScreen';
  static const String settings = '/settings';

  static const String summary = '/summary';
}

class AppRouters {
  static Route<dynamic> generateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => SplashView());
      case Routes.home:
        return MaterialPageRoute(builder: (context) => HomeView());

      case Routes.goalDetails:
        final GoalCardModel argument = routeSettings.arguments as GoalCardModel;
        return MaterialPageRoute(
          builder: (context) => GoalDetailsView(goalCard: argument),
        );
      case Routes.addGoal:
        return MaterialPageRoute(builder: (context) => AddGoal());
      case Routes.completed:
        final goal = routeSettings.arguments as GoalCardModel;
        return MaterialPageRoute(
          builder: (context) => GoalCompletedView(goal: goal),
        );

      case Routes.summary:
        final GoalCardModel goalA = routeSettings.arguments as GoalCardModel;

        return MaterialPageRoute(
          builder: (context) => SummaryCardView(goal: goalA),
        );
      case Routes.completedScreen:
        return MaterialPageRoute(builder: (context) => CompletedGoalView());

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No route defined for ${routeSettings.name}'),
            ),
          ),
        );
    }
  }
}
