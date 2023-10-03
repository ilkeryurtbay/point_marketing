import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:point_marketing/src/features/admin/domain/i_suggestion_model.dart';

class SuggestionField<T extends ISuggestionModel> extends StatefulWidget {
  final TextEditingController controller;
  final FutureOr<Iterable<T>> Function(String) getSuggestionMethod;

  const SuggestionField({
    Key? key,
    required this.controller,
    required this.getSuggestionMethod,
  }) : super(key: key);

  @override
  State<SuggestionField<T>> createState() => _SuggestionFieldState<T>();
}

class _SuggestionFieldState<T extends ISuggestionModel>
    extends State<SuggestionField<T>> {
  @override
  Widget build(BuildContext context) {
    return TypeAheadField<T?>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: widget.controller,
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
    );
  }
}
