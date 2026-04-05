import 'package:flutter/material.dart';

import '../../core/utils/app_textStyle.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final double? height;
  final Widget? suffixIcon;
  final int maxLines;
  final int minLines;
  final bool? readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;

  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.title,
    this.controller,
    this.height = 55,
    this.suffixIcon,
    this.readOnly,
    this.onTap,
    this.validator,
    this.maxLines = 1,
    this.minLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.labelMedium.copyWith(
            color: Colors.grey.shade500,
          ),
        ),
        SizedBox(height: 10),

        TextFormField(
          controller: controller,
          onTap: onTap,
          validator: validator,
          readOnly: readOnly ?? false,
          maxLines: maxLines,

          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 15,
            ),
            // Normal Border
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            // Border when clicking the field
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            // Border when validation FAILS
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
            // Border when validation FAILS and you click it
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
