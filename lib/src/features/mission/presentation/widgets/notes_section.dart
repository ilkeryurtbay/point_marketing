import 'package:flutter/material.dart';
import 'package:point_marketing/src/features/mission/application/form_validator.dart';

class NotesSection extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  NotesSection({required this.controller, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: (value) => nonEmptyValidator(value),
        decoration: InputDecoration(label: Text(labelText)),
        controller: controller,
        maxLines: 2,
        onChanged: (value) {
          print('Market ismi: $value');
        });
  }
}
