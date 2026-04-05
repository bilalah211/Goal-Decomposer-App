import 'package:flutter/material.dart';

import '../../core/utils/media_query_helper.dart';
import '../../data/models/goal_model.dart';

class LinearProgress extends StatelessWidget {
  const LinearProgress({super.key, required this.goalCard});

  final GoalCardModel goalCard;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: MediaQueryHelper.width(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: LinearProgressIndicator(
          value: goalCard.progress ?? 0.0,
          backgroundColor: Colors.grey[200],

          minHeight: 8,
          valueColor: AlwaysStoppedAnimation<Color>(goalCard.progressColor),
        ),
      ),
    );
  }
}
