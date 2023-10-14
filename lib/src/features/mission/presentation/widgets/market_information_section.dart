import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:point_marketing/src/features/mission/application/form_validator.dart';

class MarketInformationSection extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  const MarketInformationSection({
    Key? key,
    required this.labelText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 1,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]+')),
      ],
      validator: (value) => nonEmptyValidator(value),
      onChanged: (value) {
        print('Market ismi: $value');
      },
      decoration: InputDecoration(
        labelText: labelText, 
      ),
    );
  }
}
