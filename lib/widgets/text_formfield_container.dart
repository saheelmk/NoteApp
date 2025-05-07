import 'package:flutter/material.dart';
import 'package:note_app/core/app_colors.dart';

class TextFormfieldContainer extends StatelessWidget {
  TextFormfieldContainer({
    super.key,
    required this.controller,
    required this.labelText,
  });

  final TextEditingController controller;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => controller.text = value,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 15), //
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ), // Label color
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.light,
            width: 3,
          ), // Default border
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.dark,
            width: 2,
          ), // When focused
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
