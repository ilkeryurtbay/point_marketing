import 'package:flutter/material.dart';

class EmployeeNotesSection extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const EmployeeNotesSection({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: TextField(
        controller: controller,
        maxLines: 2,
        onChanged: onChanged,
      ),
    );
  }
}
