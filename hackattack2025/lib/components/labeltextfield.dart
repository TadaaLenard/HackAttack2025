import 'package:flutter/material.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final String placeholder;
  final TextEditingController controller;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 17,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: const TextStyle(color: Colors.grey),
            // contentPadding:
            //     const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
