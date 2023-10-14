part of 'package:point_marketing/src/features/admin/presentation/admin_page.dart';

class _ProductSuggestionField extends StatefulWidget {
  final TextEditingController controller;
  final FutureOr<Iterable<Product>> Function(String) getSuggestionMethod;

  const _ProductSuggestionField({
    Key? key,
    required this.controller,
    required this.getSuggestionMethod,
  }) : super(key: key);

  @override
  State<_ProductSuggestionField> createState() =>
      _ProductSuggestionFieldState();
}

class _ProductSuggestionFieldState extends State<_ProductSuggestionField> {
  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Product?>(
      textFieldConfiguration: TextFieldConfiguration(
          controller: widget.controller,
          decoration: const InputDecoration(
            labelText: AppString.product,
            suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
          )),
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
          //show the product name in the text field
          widget.controller.text = suggestion?.name ?? '';
        });
      },
      noItemsFoundBuilder: (context) => const SizedBox(),
      debounceDuration: const Duration(milliseconds: 800),
    );
  }
}
