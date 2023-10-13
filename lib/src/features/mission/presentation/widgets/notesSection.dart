import 'package:flutter/material.dart';

class NotesSection extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String labelText;

  NotesSection({
    required this.controller,
    required this.onChanged,
    required this.labelText
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Expanded(child: Text(labelText)),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextField(
            controller: controller,
            maxLines: 2,
            onChanged: onChanged,
          ),
        )
      ],
    );
  }
}
