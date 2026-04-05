import 'package:flutter/material.dart';
import 'package:goal_decomposer/data/models/goal_model.dart';
import '../../core/theme/app_colors.dart';
import 'circular_progress.dart';
import 'linear_progress.dart';

class GoalCard extends StatelessWidget {
  final GoalCardModel goalCard;
  final VoidCallback? donTap;
  final VoidCallback? onTap;
  final bool isDeletedIcon;

  const GoalCard({
    super.key,
    required this.goalCard,
    this.donTap,
    this.onTap,
    this.isDeletedIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.backgroundGreyColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),

            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //---[Goal Title]---
                            Text(goalCard.title),
                            SizedBox(height: 10),

                            //---[Linear Progress Section]---
                            LinearProgress(goalCard: goalCard),
                          ],
                        ),
                      ),
                    ),

                    //---[Circular Progress Section]---
                    CircularProgress(goalCard: goalCard),
                  ],
                ),
              ],
            ),
          ),
        ),
        isDeletedIcon
            ? Positioned(
                top: 0,
                right: 10,
                child: GestureDetector(
                  onTap: donTap,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4),
                      ],
                    ),
                    child: Icon(Icons.delete, size: 18, color: Colors.red),
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
