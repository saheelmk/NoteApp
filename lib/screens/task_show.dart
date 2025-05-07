import 'package:flutter/material.dart';
import 'package:note_app/core/app_colors.dart';

class TaskPage extends StatelessWidget {
  TaskPage({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Minimalist Note App",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.dark,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 30, left: 20, right: 20),
        padding: EdgeInsets.all(20),
        height: 550,
        width: 370,
        decoration: BoxDecoration(
          color: AppColors.light,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [BoxShadow(offset: Offset(5.1, 4.5), blurRadius: 8.1)],
        ),
        child: ListView(
          children: [
            Column(
              children: [
                Text(
                  maxLines: 1,
                  title,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
