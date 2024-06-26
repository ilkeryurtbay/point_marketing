import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:point_marketing/src/features/mission/application/form_validator.dart';

class NumberControlSection extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  const NumberControlSection({
    super.key,
    required this.labelText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      decoration:  InputDecoration(
        labelText: labelText ,
      ),
       validator: (value) => nonEmptyValidator(value),
      onChanged: (value) {
        // Girilen sayıyı kullanmak için burada işlem yapabilirsiniz.
        print('Girilen sayı: $value');
      },
    );
  }
}
