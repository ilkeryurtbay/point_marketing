import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:point_marketing/core/constants/app_space.dart';
import 'package:point_marketing/core/constants/app_string.dart';
import 'package:point_marketing/src/features/admin/application/selected_product.dart';
import 'package:point_marketing/src/features/admin/data/entity/agent_entity.dart';
import 'package:point_marketing/src/features/admin/data/entity/company_entity.dart';
import 'package:point_marketing/src/features/admin/domain/i_suggestion_model.dart';
import 'package:point_marketing/src/features/admin/presentation/widgets/product_suggestion_field.dart';
import 'package:point_marketing/src/features/admin/presentation/widgets/suggestion_field.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_padding.dart';
import '../data/entity/market_entity.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late TextEditingController _dateController;
  late TextEditingController _marketController;
  late TextEditingController _companyController;
  late TextEditingController _productController;
  late TextEditingController _agentController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
    _marketController = TextEditingController();
    _companyController = TextEditingController();
    _productController = TextEditingController();
    _agentController = TextEditingController();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _marketController.dispose();
    _companyController.dispose();
    _productController.dispose();
    _agentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Padding(
          padding: AppPadding.allSides24,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: AppString.date,
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
              AppSpace.vertical.space20,
              SuggestionField<Market>(
                controller: _marketController,
                getSuggestionMethod: (pattern) =>
                    getSuggestions<Market>(pattern, Market.fromJson),
              ),
              AppSpace.vertical.space20,
              SuggestionField<Company>(
                controller: _companyController,
                getSuggestionMethod: (pattern) =>
                    getSuggestions(pattern, Company.fromJson),
              ),
              AppSpace.vertical.space20,
              Row(
                children: [
                  Expanded(
                    child: ProductSuggestionField(
                      controller: _productController,
                    ),
                  ),
                  AppSpace.horizontal.space40,
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    //add the selected product, which is being held in Selected Product Change Notifier, to the list to show in the list view
                    onTap: () =>
                        Provider.of<SelectedProduct>(context, listen: false)
                            .addSelectedProductToList(),
                    child: const Icon(
                      Icons.add_box_outlined,
                      size: 60,
                    ),
                  ),
                ],
              ),
              AppSpace.vertical.space20,
              const Text('Selected Products'),
              AppSpace.vertical.space20,
              Expanded(child: Consumer<SelectedProduct>(
                builder: (context, selectedProduct, child) {
                  return ListView.builder(
                    itemCount: selectedProduct.selectedProducts.length,
                    itemBuilder: (context, index) {
                      final product = selectedProduct.selectedProducts[index];
                      return ListTile(
                        title: Text(product.name ??
                            'product name could not be retrieved'),
                        subtitle: Text(product.companyName ??
                            'company name could not be retrieved'),
                      );
                    },
                  );
                },
              )),
              AppSpace.vertical.space20,
              SuggestionField(
                controller: _agentController,
                getSuggestionMethod: (pattern) =>
                    getSuggestions<Agent>(pattern, Agent.fromJson),
              ),
              AppSpace.vertical.space20,
              Center(
                child: ElevatedButton(
                    onPressed: () => print('Data sent'),
                    child: const Text('SEND MISSION')),
              )
            ],
          ),
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

  ///Uses the passed fromJson function to convert the raw json data of the given model from database
  ///into a list of entities then use the pattern to filter the list and show relevant suggestions
  FutureOr<Iterable<T>> getSuggestions<T extends ISuggestionModel>(
      String pattern, T Function(Map<String, dynamic>) fromJson) async {
    //TODO:Update the data source when firebase is ready!
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
