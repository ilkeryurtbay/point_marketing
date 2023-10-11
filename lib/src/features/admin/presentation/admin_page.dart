import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:point_marketing/core/constants/app_space.dart';
import 'package:point_marketing/core/constants/app_string.dart';
import 'package:point_marketing/core/util/build_context_extension.dart';
import 'package:point_marketing/src/features/admin/application/selected_product_provider.dart';
import 'package:point_marketing/src/features/admin/application/validation_provider.dart';
import 'package:point_marketing/src/features/admin/data/entity/agent_entity.dart';
import 'package:point_marketing/src/features/admin/data/entity/city_entity.dart';
import 'package:point_marketing/src/features/admin/data/entity/company_entity.dart';
import 'package:point_marketing/src/features/admin/domain/i_suggestion_model.dart';
import 'package:point_marketing/src/features/admin/presentation/widgets/product_suggestion_field.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_padding.dart';
import '../data/entity/country_entity.dart';
import '../data/entity/market_entity.dart';
import '../data/entity/product_entity.dart';

part 'package:point_marketing/src/features/admin/presentation/widgets/app_bar_back_button.dart';
part 'package:point_marketing/src/features/admin/presentation/widgets/check_circle.dart';
part 'package:point_marketing/src/features/admin/presentation/widgets/date_picker_field.dart';
part 'package:point_marketing/src/features/admin/presentation/widgets/product_tile.dart';
part 'package:point_marketing/src/features/admin/presentation/widgets/suggestion_field.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _dateController;
  late TextEditingController _marketController;
  late TextEditingController _companyController;
  late TextEditingController _productController;
  late TextEditingController _countryController;
  late TextEditingController _cityController;
  late TextEditingController _noteController;
  late TextEditingController _agentController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _dateController = TextEditingController();
    _marketController = TextEditingController();
    _companyController = TextEditingController();
    _productController = TextEditingController();
    _countryController = TextEditingController();
    _cityController = TextEditingController();
    _noteController = TextEditingController();
    _agentController = TextEditingController();
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
    _agentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double scrollBarRadius = 10;
    const double scrollbarThickness = 5;
    const double addProductButtonRadius = 8;
    const double productListRadius = 12;
    final showValidation =
        Provider.of<ValidationProvider>(context).showValidation;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppString.addMission,
        ),
        leading: const _AppBarBackButton(),
      ),
      body: RawScrollbar(
        thumbVisibility: true,
        padding: AppPadding.onlyRight4,
        thumbColor: context.mainThemeColor,
        thickness: scrollbarThickness,
        radius: const Radius.circular(scrollBarRadius),
        interactive: true,
        child: Padding(
          padding: AppPadding.pagePadding,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpace.vertical.space10,
                  _DatePickerField(
                    controller: _dateController,
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
                          borderRadius:
                              BorderRadius.circular(addProductButtonRadius),
                          //add the selected product, which is being held in Selected Product Change Notifier, to the list to show in the list view
                          onTap: () {
                            SelectedProductProvider provider =
                                Provider.of<SelectedProductProvider>(context,
                                    listen: false);

                            final companyName = _companyController.text.trim();
                            final productName = _productController.text.trim();
                            //check if one of the names left empty
                            if (companyName.isNotEmpty &&
                                productName.isNotEmpty) {
                              provider.selectedProduct = Product(
                                  name: productName, companyName: companyName);
                            } else {
                              //show snack bar to make the user fill the empty fields
                              _showErrorSnackBar(
                                  context: context,
                                  text: AppString.fillEmptyNames);
                              return;
                            }
                            //if the selected product is not added before, add it to the selectedProducts list
                            if (!provider.selectedProducts
                                .contains(provider.selectedProduct)) {
                              provider.addSelectedProductToList();
                              _productController.clear();
                            } else {
                              //show a snack bar to the user that is telling they are trying to add the same product more than once
                              _showErrorSnackBar(
                                  context: context,
                                  text: AppString.productAlreadyAdded);
                            }
                          },
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              decoration: _buildRoundedShape(
                                  context: context,
                                  radius: addProductButtonRadius),
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
                  Consumer<SelectedProductProvider>(
                    builder: (context, selectedProduct, child) {
                      final bool showError = showValidation &&
                          selectedProduct.selectedProducts.isEmpty;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 240,
                            decoration: _buildRoundedShape(
                                context: context,
                                radius: productListRadius,
                                borderColor: showError
                                    ? context.colorScheme.error
                                    : context.outlineColor),
                            child: ListView.builder(
                              itemCount:
                                  selectedProduct.selectedProducts.length,
                              itemBuilder: (context, index) {
                                final product =
                                    selectedProduct.selectedProducts[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 6.0, left: 4, right: 4),
                                  child: _ProductTile(product: product),
                                );
                              },
                            ),
                          ),
                          if (showError) ...[
                            AppSpace.vertical.space5,
                            Padding(
                              padding: AppPadding.onlyLeft16,
                              child: Text(
                                'Lütfen tanıtılacak ürün ekleyin',
                                style: TextStyle(color: context.errorColor),
                              ),
                            )
                          ],
                        ],
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
                  SuggestionField(
                    controller: _agentController,
                    labelText: AppString.agent,
                    getSuggestionMethod: (pattern) =>
                        getSuggestions<Agent>(pattern, Agent.fromJson),
                  ),
                  AppSpace.vertical.space20,
                  TextField(
                    controller: _noteController,
                    minLines: 5,
                    maxLines: 10,
                    maxLength: 1500,
                    decoration: const InputDecoration(
                      hintText: AppString.addNotes,
                      labelText: AppString.notes,
                      alignLabelWithHint: true,
                    ),
                  ),
                  AppSpace.vertical.space20,
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          Provider.of<ValidationProvider>(context,
                                  listen: false)
                              .activateAllValidations();
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => const AgentMissionForm(),
                          //     ));
                        }, //TODO: implement validation and save method
                        child: const Text(AppString.save)),
                  ),
                  AppSpace.vertical.space60,
                ],
              ),
            ),
          ),
        ),
      ),
    );
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

  ShapeDecoration _buildRoundedShape(
      {required BuildContext context,
      required double radius,
      Color? borderColor}) {
    return ShapeDecoration(
        shape: RoundedRectangleBorder(
            side: BorderSide(
              width: borderColor == context.colorScheme.error ? 2 : 1,
              color: borderColor ?? context.outlineColor,
            ),
            borderRadius: BorderRadius.circular(radius)));
  }

  void _showErrorSnackBar(
      {required BuildContext context, required String text}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Center(child: Text(text))));
  }
}
