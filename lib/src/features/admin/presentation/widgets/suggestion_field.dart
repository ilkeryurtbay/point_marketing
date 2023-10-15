part of 'package:point_marketing/src/features/admin/presentation/admin_page.dart';

class _SuggestionField<T extends ISuggestionModel> extends StatefulWidget {
  final TextEditingController controller;
  final FutureOr<Iterable<T>> Function(String) getSuggestionMethod;
  final String labelText;
  final void Function(T?)? onSuggestionSelected;

  const _SuggestionField({
    Key? key,
    required this.controller,
    required this.getSuggestionMethod,
    required this.labelText,
    this.onSuggestionSelected,
  }) : super(key: key);

  @override
  State<_SuggestionField<T>> createState() => _SuggestionFieldState<T>();
}

class _SuggestionFieldState<T extends ISuggestionModel>
    extends State<_SuggestionField<T>> {
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
      //when the suggestion is selected, if no specific function is given, the name of the suggestion will be shown in the text form field
      onSuggestionSelected: widget.onSuggestionSelected ??
          (suggestion) {
            widget.controller.text = suggestion?.name ?? '';
          },
      noItemsFoundBuilder: (context) => const SizedBox(),
      debounceDuration: const Duration(milliseconds: 800),
      autoFlipDirection: true,
    );
  }
}
