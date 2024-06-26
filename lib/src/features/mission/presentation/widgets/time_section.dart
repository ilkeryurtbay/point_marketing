import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:point_marketing/src/features/mission/application/form_validator.dart';

class TimeSection extends StatelessWidget {
  final TextEditingController controller;

  final String labelText;

  const TimeSection({
    Key? key,
    required this.controller,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
        _TimeInputFormatter(),
      ],
      decoration:  InputDecoration(
        labelText: labelText ,
      ),
      validator: (value) => nonEmptyValidator(value),
      onChanged: (value) {
        // Girilen değeri kullanmak için burada işlem yapabilirsiniz.
        print('Girilen saat: $value');
      },
    );
  }
}

class _TimeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    var newText = '';

    // Saat dilimi sınırları kontrol edilir
    if (text.length >= 1) {
      final firstDigit = int.tryParse(text[0]);
      if (firstDigit != null && firstDigit >= 0 && firstDigit <= 2) {
        newText += text[0];
      }
    }

    if (text.length >= 2) {
      final secondDigit = int.tryParse(text[1]);
      if (secondDigit != null) {
        if (int.tryParse(newText) == 2) {
          if (secondDigit >= 0 && secondDigit <= 3) {
            newText += text[1] + ':';
          }
        } else if (secondDigit >= 0 && secondDigit <= 9) {
          newText += text[1] + ':';
        }
      }
    }

    // Dakika sınırları kontrol edilir
    if (text.length >= 3) {
      final thirdDigit = int.tryParse(text[2]);
      if (thirdDigit != null && thirdDigit >= 0 && thirdDigit <= 5) {
        newText += text[2];
      }
    }

    if (text.length >= 4) {
      final fourthDigit = int.tryParse(text[3]);
      if (fourthDigit != null && fourthDigit >= 0 && fourthDigit <= 9) {
        newText += text[3];
      }
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
