import 'package:flutter/material.dart';

void mySnackBarMessenger(
  BuildContext context,
  String title,
  IconData icon,
  Color backgroundColor,
  Color iconColor,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: EdgeInsets.symmetric(horizontal: 10),

      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor),
          SizedBox(width: 5),
          Text(title),
        ],
      ),
    ),
  );
}
