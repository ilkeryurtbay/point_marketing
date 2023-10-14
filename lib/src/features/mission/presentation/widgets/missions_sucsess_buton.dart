
// custom_button.dart dosyası
import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  CustomSubmitButton({
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) { }
      },
      child: Text("Görevi Tamamla"),
    );
  }
}
