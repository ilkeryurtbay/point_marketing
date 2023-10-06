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
    const double scrollBarRadius = 10;
    const double scrollbarThickness = 5;
    final roundedOutlineBorderWithRadius8 = ShapeDecoration(
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: context.outlineColor,
            ),
            borderRadius: BorderRadius.circular(8)));

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
                                        right: 0, child: _CheckCircle())
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
                _DatePickerField(controller: _dateController),
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
                            decoration: roundedOutlineBorderWithRadius8,
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
                    return Container(
                      height: 200,
                      decoration: roundedOutlineBorderWithRadius8,
                      child: ListView.builder(
                        itemCount: selectedProduct.selectedProducts.length,
                        itemBuilder: (context, index) {
                          final product =
                              selectedProduct.selectedProducts[index];
                          return _ProductTile(product: product);
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

  void _showErrorSnackBar(
      {required BuildContext context, required String text}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Center(child: Text(text))));
  }
}
