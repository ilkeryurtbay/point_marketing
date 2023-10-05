import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:point_marketing/core/constants/app_space.dart';
import 'package:point_marketing/core/constants/app_string.dart';
import 'package:point_marketing/core/util/build_context_extension.dart';
import 'package:point_marketing/src/features/admin/application/selected_product.dart';
import 'package:point_marketing/src/features/admin/data/entity/city_entity.dart';
import 'package:point_marketing/src/features/admin/data/entity/company_entity.dart';
import 'package:point_marketing/src/features/admin/domain/i_suggestion_model.dart';
import 'package:point_marketing/src/features/admin/presentation/widgets/product_suggestion_field.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_padding.dart';
import '../data/entity/country_entity.dart';
import '../data/entity/market_entity.dart';

part 'package:point_marketing/src/features/admin/presentation/widgets/suggestion_field.dart';

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
  late TextEditingController _countryController;
  late TextEditingController _cityController;
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
    _marketController = TextEditingController();
    _companyController = TextEditingController();
    _productController = TextEditingController();
    _countryController = TextEditingController();
    _cityController = TextEditingController();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _marketController.dispose();
    _companyController.dispose();
    _productController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double topListHeight = 160;
    final roundedRectangleShapeDecoration = ShapeDecoration(
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: BorderRadius.circular(8)));
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppString.addMission,
        ),
        leading: const _BackButton(),
      ),
      body: RawScrollbar(
        thumbVisibility: true,
        padding: AppPadding.onlyRight4,
        thumbColor: context.mainThemeColor,
        thickness: 5,
        radius: const Radius.circular(10),
        interactive: true,
        child: Padding(
          padding: AppPadding.pagePadding,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: topListHeight,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: topListHeight * 0.75,
                                width: topListHeight * 0.75,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        radius: topListHeight / 3.25,
                                      ),
                                    ),
                                    const Positioned(
                                        right: 0, child: CheckCircle())
                                  ],
                                ),
                              ),
                              const Text('Eleman Adı'),
                            ],
                          ),
                          AppSpace.horizontal.space20,
                        ],
                      );
                    },
                  ),
                ),
                TextField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    labelText: AppString.date,
                    suffixIcon: Icon(Icons.calendar_today_outlined),
                  ),
                  readOnly: true,
                  onTap: _selectDate,
                ),
                AppSpace.vertical.space20,
                SuggestionField<Market>(
                  controller: _marketController,
                  labelText: AppString.market,
                  getSuggestionMethod: (pattern) =>
                      getSuggestions<Market>(pattern, Market.fromJson),
                ),
                AppSpace.vertical.space20,
                SuggestionField<Company>(
                  controller: _companyController,
                  labelText: AppString.company,
                  getSuggestionMethod: (pattern) =>
                      getSuggestions(pattern, Company.fromJson),
                ),
                AppSpace.vertical.space20,
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ProductSuggestionField(
                        controller: _productController,
                      ),
                    ),
                    AppSpace.horizontal.space10,
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        //add the selected product, which is being held in Selected Product Change Notifier, to the list to show in the list view
                        onTap: () =>
                            Provider.of<SelectedProduct>(context, listen: false)
                                .addSelectedProductToList(),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: roundedRectangleShapeDecoration,
                            child: Icon(
                              Icons.add_outlined,
                              color: context.outlineColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                AppSpace.vertical.space20,
                const Text(AppString.chosenProducts),
                AppSpace.vertical.space5,
                Consumer<SelectedProduct>(
                  builder: (context, selectedProduct, child) {
                    return Container(
                      height: 200,
                      decoration: roundedRectangleShapeDecoration,
                      child: ListView.builder(
                        itemCount: selectedProduct.selectedProducts.length,
                        itemBuilder: (context, index) {
                          final product =
                              selectedProduct.selectedProducts[index];
                          return ListTile(
                            title: Text(product.name ??
                                'product name could not be retrieved'),
                            subtitle: Text(product.companyName ??
                                'company name could not be retrieved'),
                          );
                        },
                      ),
                    );
                  },
                ),
                AppSpace.vertical.space20,
                SuggestionField(
                  controller: _countryController,
                  labelText: AppString.country,
                  getSuggestionMethod: (pattern) =>
                      getSuggestions<Country>(pattern, Country.fromJson),
                ),
                AppSpace.vertical.space20,
                SuggestionField(
                  controller: _cityController,
                  labelText: AppString.city,
                  getSuggestionMethod: (pattern) =>
                      getSuggestions<City>(pattern, City.fromJson),
                ),
                AppSpace.vertical.space20,
                TextField(
                  controller: _noteController,
                  minLines: 5,
                  maxLines: 10,
                  maxLength: 1500,
                  decoration: const InputDecoration(
                    hintText: AppString.addNotes,
                  ),
                ),
                AppSpace.vertical.space20,
                Center(
                  child: ElevatedButton(
                      onPressed: () {}, //TODO: implement save method
                      child: const Text(AppString.save)),
                ),
                AppSpace.vertical.space60,
              ],
            ),
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
      lastDate: DateTime(2100),
    );

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

class CheckCircle extends StatefulWidget {
  const CheckCircle({super.key});

  @override
  State<CheckCircle> createState() => _CheckCircleState();
}

class _CheckCircleState extends State<CheckCircle> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: isChecked
          ? Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
                const Icon(
                  Icons.check,
                  color: Colors.white,
                )
              ],
            )
          : Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
            ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Icon(
        Icons.arrow_back_ios_new_outlined,
        color: context.mainThemeColor,
      ),
    );
  }
}
