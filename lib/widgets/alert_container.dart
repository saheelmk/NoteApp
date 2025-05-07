import 'package:flutter/material.dart';
import 'package:note_app/core/app_colors.dart';

class AlertContainer extends StatelessWidget {
  const AlertContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: AppColors.accent,
      title: Text(
        'Welcome!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: AppColors.light,
        ),
      ),
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Let\'s get started with your To-Do list today!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 23,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            CircularProgressIndicator(
              strokeWidth: 5.5,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.light),
              backgroundColor: AppColors.dark,
            ),
          ],
        ),
      ),
    );
  }
}
