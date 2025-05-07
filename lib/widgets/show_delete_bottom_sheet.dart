import 'package:flutter/material.dart';
import 'package:note_app/core/app_colors.dart';

void showDeleteBottomSheet(
  BuildContext context,
  VoidCallback onMoveToRecycleBin, {
  required String text,
  required String subtext,
}) {
  showModalBottomSheet(
    backgroundColor: AppColors.light,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Are you sure?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(text, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close bottom sheet
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.black,

                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close bottom sheet first
                      onMoveToRecycleBin(); // Call your function
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: Text(
                      subtext,
                      style: TextStyle(
                        color: Colors.black,

                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
