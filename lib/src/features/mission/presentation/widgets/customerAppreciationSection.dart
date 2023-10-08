import 'package:flutter/material.dart';

class customerAppreciationSaction extends StatefulWidget {
  final String? selectedOption;
  final ValueChanged<String?> onChanged;

  customerAppreciationSaction({
    required this.selectedOption,
    required this.onChanged,
  });

  @override
  _customerAppreciationSactionState createState() =>
      _customerAppreciationSactionState();
}

class _customerAppreciationSactionState
    extends State<customerAppreciationSaction> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        child: DropdownButton<String>(
          value: widget.selectedOption,
          onChanged: widget.onChanged,
          items: <String>['İyi', 'Orta', 'Kötü'].map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Center(
                  child: Text(value, textAlign: TextAlign.center),
                ),
              );
            },
          ).toList(),
          hint: const Text('Seçiniz'), // Hint metni (placeholder)
        ),
      ),
    );
  }
}
