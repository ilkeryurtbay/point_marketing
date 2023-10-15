import 'package:flutter/material.dart';
import 'package:point_marketing/src/features/mission/application/form_validator.dart';

class InterestSection extends StatefulWidget {
  final String? selectedOption;
  final String hintText;
  final ValueChanged<String?> onChanged;

  InterestSection({
    required this.selectedOption,
    required this.onChanged,
    required this.hintText,
  });

  @override
  _InterestSectionState createState() => _InterestSectionState();
}

class _InterestSectionState extends State<InterestSection> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        
        DropdownButtonFormField<String>(
          value: widget.selectedOption,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: widget.hintText,
          ),
          items: <String>['İyi', 'Orta', 'Kötü'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Center(
                child: Text(value, textAlign: TextAlign.center),
              ),
            );
          }).toList(),
          validator: (value) => nonEmptyValidator(value),
        ),
      ],
    );
  }
}
