import 'package:flutter/material.dart';

class PassiveMarketInformationSection extends StatelessWidget {
  final String text;

  const PassiveMarketInformationSection({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true, 
      controller: TextEditingController(text: text,),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black45, width: 1.0),
          borderRadius: BorderRadius.circular(7), 
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black45, width: 1.0),
          borderRadius: BorderRadius.circular(7), 
        ),
      ),
    );
  }
}
