part of 'package:point_marketing/src/features/admin/presentation/admin_page.dart';

class SuggestionField<T extends ISuggestionModel> extends StatefulWidget {
  final TextEditingController controller;
  final FutureOr<Iterable<T>> Function(String) getSuggestionMethod;
  final String labelText;

  const SuggestionField({
    Key? key,
    required this.controller,
    required this.getSuggestionMethod,
    required this.labelText,
  }) : super(key: key);

  @override
  State<SuggestionField<T>> createState() => _SuggestionFieldState<T>();
}

class _SuggestionFieldState<T extends ISuggestionModel>
    extends State<SuggestionField<T>> {
  @override
  Widget build(BuildContext context) {
    bool showValidation =
        Provider.of<ValidationProvider>(context).showValidation;
    return TypeAheadFormField<T?>(
      autovalidateMode:
          showValidation ? AutovalidateMode.always : AutovalidateMode.disabled,
      validator: (value) {
        return widget.controller.text.trim().isEmpty
            ? 'Lütfen bu alanı doldurun'
            : null;
      },
      textFieldConfiguration: TextFieldConfiguration(
        controller: widget.controller,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: widget.labelText,
          suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
          //errorText: 'Lütfen bu alanı doldurun',
        ),
      ),
      suggestionsCallback: widget.getSuggestionMethod,
      itemBuilder: (context, suggestion) {
        if (suggestion != null) {
          return ListTile(
            title: Text(suggestion.name ?? 'name could not be retrieved'),
          );
        } else {
          return const Text('Unexpected error');
        }
      },
      onSuggestionSelected: (suggestion) {
        setState(() {
          widget.controller.text = suggestion?.name ?? '';
        });
      },
      noItemsFoundBuilder: (context) => const SizedBox(),
      debounceDuration: const Duration(milliseconds: 800),
      autoFlipDirection: true,
    );
  }
}
