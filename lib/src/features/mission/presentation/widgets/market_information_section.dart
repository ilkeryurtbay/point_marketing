import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return Row(
      children: [
        Expanded(
          child: Text(labelText),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextField(
            controller: controller,
            maxLines: 1,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]+')),
            ],
            onChanged: (value) {
              print('Market ismi: $value');
            },
          ),
        ),
      ],
    );
  }
}
