import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:point_marketing/src/features/admin/application/selected_product.dart';
import 'package:point_marketing/src/features/admin/data/entity/product_entity.dart';
import 'package:provider/provider.dart';

class ProductSuggestionField extends StatefulWidget {
  final TextEditingController controller;

  const ProductSuggestionField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ProductSuggestionField> createState() => _ProductSuggestionFieldState();
}

class _ProductSuggestionFieldState extends State<ProductSuggestionField> {
  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Product?>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: widget.controller,
      ),
      suggestionsCallback: (pattern) =>
          _getProductSuggestions(pattern, Product.fromJson),
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

          //update the product in change notifier to make it ready to be added to the list view
          Provider.of<SelectedProduct>(context, listen: false).selectedProduct =
              suggestion;
          print(
              'product name under provider is: ${Provider.of<SelectedProduct>(context, listen: false).selectedProduct?.name}');
        });
      },
      noItemsFoundBuilder: (context) => const SizedBox(),
      debounceDuration: const Duration(milliseconds: 800),
    );
  }

  FutureOr<Iterable<Product>> _getProductSuggestions(
      String pattern, Product Function(Map<String, dynamic>) fromJson) async {
    //TODO:Update the data source when firebase is ready!
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List dataOfProducts = json.decode(response.body);

      return dataOfProducts.map((json) => fromJson(json)).where((product) {
        final productNameLower = product.name?.toLowerCase();
        final patternLower = pattern.toLowerCase();

        return productNameLower?.contains(patternLower) ?? false;
      }).toList();
    } else if (response.statusCode == 400) {
      //TODO: Handle exceptions
      throw Exception('No internet connection');
    } else {
      throw Exception('Unexpected Error');
    }
  }
}
