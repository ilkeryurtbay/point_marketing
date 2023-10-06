part of 'package:point_marketing/src/features/admin/presentation/admin_page.dart';

class _DatePickerField extends StatefulWidget {
  final TextEditingController controller;

  const _DatePickerField({super.key, required this.controller});

  @override
  State<_DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<_DatePickerField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: const InputDecoration(
        labelText: AppString.date,
        suffixIcon: Icon(Icons.calendar_today_outlined),
      ),
      readOnly: true,
      onTap: _selectDate,
    );
  }

  Future<void> _selectDate() async {
    final DateFormat dateFormat = DateFormat('dd.MM.yyyy');
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        widget.controller.text = dateFormat.format(pickedDate).toString();
      });
    }
  }
}