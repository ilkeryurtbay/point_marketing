import 'package:flutter/material.dart';

class marketerNotesSection extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  marketerNotesSection({
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
