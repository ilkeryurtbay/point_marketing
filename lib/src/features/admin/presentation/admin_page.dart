import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:point_marketing/src/features/admin/domain/i_suggestion_model.dart';
import 'package:point_marketing/src/features/admin/presentation/widgets/suggestion_field.dart';

import '../data/entity/market_entity.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late TextEditingController _dateController;
  late TextEditingController _marketController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
    _marketController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: 'TARİH',
                filled: true,
                fillColor: Colors.white,
                suffixIcon: Icon(Icons.calendar_today_outlined),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              readOnly: true,
              onTap: _selectDate,
            ),
            const SizedBox(
              height: 20,
            ),
            TypeAheadField<Market?>(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _marketController,
              ),
              suggestionsCallback: (pattern) => getSuggestions<Market>(
                  pattern, (json) => Market.fromJson(json)),
              itemBuilder: (context, suggestion) {
                if (suggestion != null) {
                  return ListTile(
                    title:
                        Text(suggestion.name ?? 'name could not be retrieved'),
                  );
                } else {
                  return const Text('Unexpected error');
                }
              },
              onSuggestionSelected: (suggestion) {
                setState(() {
                  _marketController.text = suggestion?.name ?? '';
                });
              },
              noItemsFoundBuilder: (context) => const SizedBox(),
              debounceDuration: const Duration(milliseconds: 800),
            ),
            const SizedBox(
              height: 20,
            ),
            SuggestionField<Market>(
              controller: _marketController,
              getSuggestionMethod: (pattern) =>
                  getSuggestions<Market>(pattern, Market.fromJson),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateFormat dateFormat = DateFormat('dd.MM.yyyy');
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      setState(() {
        _dateController.text = dateFormat.format(pickedDate).toString();
      });
    }
  }

  FutureOr<Iterable<Market>> getMarketSuggestions(String pattern) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List markets = json.decode(response.body);

      return markets.map((json) => Market.fromJson(json)).where((market) {
        final marketNameLower = market.name?.toLowerCase();
        final patternLower = pattern.toLowerCase();

        return marketNameLower?.contains(patternLower) ?? false;
      }).toList();
    } else if (response.statusCode == 400) {
      //TODO: Handle exceptions
      throw Exception('No internet connection');
    } else {
      throw Exception('Unexpected Error');
    }
  }

  ///Uses the passed fromJson function to convert the raw json data of the given model from database
  ///into a list of entities then use the pattern to filter the list and show relevant suggestions
  FutureOr<Iterable<T>> getSuggestions<T extends ISuggestionModel>(
      String pattern, T Function(Map<String, dynamic>) fromJson) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List dataOfEntities = json.decode(response.body);

      return dataOfEntities.map((json) => fromJson(json)).where((entity) {
        final entityNameLower = entity.name?.toLowerCase();
        final patternLower = pattern.toLowerCase();

        return entityNameLower?.contains(patternLower) ?? false;
      }).toList();
    } else if (response.statusCode == 400) {
      //TODO: Handle exceptions
      throw Exception('No internet connection');
    } else {
      throw Exception('Unexpected Error');
    }
  }
}
