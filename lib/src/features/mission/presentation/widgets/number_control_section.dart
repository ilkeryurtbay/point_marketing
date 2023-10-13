import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return Row(
      children: [
        Expanded(child: Text(labelText)),
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            decoration: const InputDecoration(
              hintText: 'Sayıyı buraya girin',
            ),
            onChanged: (value) {
              // Girilen sayıyı kullanmak için burada işlem yapabilirsiniz.
              print('Girilen sayı: $value');
            },
          ),
        )
      ],
    );
  }
}
