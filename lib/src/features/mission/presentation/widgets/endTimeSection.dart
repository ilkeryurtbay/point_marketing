import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class endTimeSetion extends StatelessWidget {
  const endTimeSetion({
    super.key,
    required TextEditingController finishTimeController,
  }) : _finishTimeController = finishTimeController;

  final TextEditingController _finishTimeController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Text("Bitiş Saati:")),
        Expanded(
          child: TextField(
            controller: _finishTimeController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(4),
              _TimeInputFormatter(),
            ],
            decoration: const InputDecoration(
              hintText: '00:00 - 23:59',
            ),
            onChanged: (value) {
              // Girilen değeri kullanmak için burada işlem yapabilirsiniz.
              print('Girilen saat: $value');
            },
          ),
        ),
      ],
    );
  }
}

class _TimeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
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