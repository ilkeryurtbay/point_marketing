import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:point_marketing/core/constants/app_space.dart';
import 'package:point_marketing/core/constants/app_string.dart';
import 'package:point_marketing/core/util/build_context_extension.dart';
import 'package:point_marketing/core/util/helpers/firebase_id_getter.dart';
import 'package:point_marketing/src/common_widgets/page_scroll_bar.dart';
import 'package:point_marketing/src/features/admin/application/selected_product_provider.dart';
import 'package:point_marketing/src/features/admin/application/validation_provider.dart';
import 'package:point_marketing/src/features/admin/domain/entity/city_entity.dart';
import 'package:point_marketing/src/features/admin/domain/entity/company_entity.dart';
import 'package:point_marketing/src/features/admin/domain/entity/employee_entity.dart';
import 'package:point_marketing/src/features/admin/domain/i_suggestion_model.dart';
import 'package:point_marketing/src/features/mission/domain/mission_entity.dart';
import 'package:point_marketing/src/features/mission/presentation/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_padding.dart';
import '../domain/entity/country_entity.dart';
import '../domain/entity/market_entity.dart';
import '../domain/entity/product_entity.dart';

part 'package:point_marketing/src/features/admin/presentation/widgets/app_bar_back_button.dart';
part 'package:point_marketing/src/features/admin/presentation/widgets/check_circle.dart';
part 'package:point_marketing/src/features/admin/presentation/widgets/date_picker_field.dart';
part 'package:point_marketing/src/features/admin/presentation/widgets/product_suggestion_field.dart';
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
  late TextEditingController _employeeController;
  Employee? selectedEmployee;

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
    _employeeController = TextEditingController();
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
    _employeeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double addProductButtonRadius = 8;
    const double productListRadius = 12;
    final showValidation =
        Provider.of<ValidationProvider>(context).showValidation;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text(
          AppString.addMission,
        ),
        leading: const _AppBarBackButton(),
        actions: [
          TextButton(
            onPressed: () async => getDocumentIdFromCollection(
                collectionString: 'countries',
                fieldNameToBeQueried: 'name',
                searchPattern: 'türkiye'),
            // AuthService()
            // .registerWithEmailAndPassword('alper@mail.com', '123456'),
            child: const Text('register'),
          ),
          TextButton(
              onPressed: () async => AuthService()
                  .signInWithEmailAndPassword('alper@mail.com', '123456'),
              child: const Text('sign in'))
        ],
      ),
      body: PageScrollBar(
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
                  _SuggestionField<Market>(
                    controller: _marketController,
                    labelText: AppString.market,
                    getSuggestionMethod: (pattern) =>
                        _getSuggestionsFromCollection<Market>(
                            collectionString: 'markets',
                            fromJson: Market.fromJson,
                            pattern: pattern),
                  ),
                  AppSpace.vertical.space20,
                  _SuggestionField<Company>(
                    controller: _companyController,
                    labelText: AppString.company,
                    getSuggestionMethod: (pattern) =>
                        _getSuggestionsFromCollection(
                            pattern: pattern,
                            collectionString: 'companies',
                            fromJson: Company.fromJson),
                  ),
                  AppSpace.vertical.space20,
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: _ProductSuggestionField(
                          controller: _productController,
                          getSuggestionMethod: (pattern) =>
                              _getSuggestionsFromSubCollection(
                                  pattern: pattern,
                                  parentDocumentName:
                                      _companyController.text.trim(),
                                  parentCollectionString: 'companies',
                                  subCollectionString: 'products',
                                  fromJson: Product.fromJson),
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
                            //check if one of the fields is left empty
                            if (companyName.isNotEmpty &&
                                productName.isNotEmpty) {
                              provider.selectedProduct =
                                  Product(name: productName);
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
                          //use aspect ratio to keep the square shape of the button on different screen sizes
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
                    builder: (context, provider, child) {
                      //if save button is tapped and the list is empty, showError will be true
                      final bool showError =
                          showValidation && provider.selectedProducts.isEmpty;
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
                              itemCount: provider.selectedProducts.length,
                              itemBuilder: (context, index) {
                                final product =
                                    provider.selectedProducts[index];
                                return Padding(
                                  padding: AppPadding.top6Horizontal4,
                                  child: _ProductTile(
                                    product: product,
                                    companyName: _companyController.text.trim(),
                                  ),
                                );
                              },
                            ),
                          ),
                          //if showError is true, an error text with some space will be added to the column and shown
                          if (showError) ...[
                            AppSpace.vertical.space5,
                            Padding(
                              padding: AppPadding.onlyLeft16,
                              child: Text(
                                AppString.addProductToPromote,
                                style: TextStyle(color: context.errorColor),
                              ),
                            )
                          ],
                        ],
                      );
                    },
                  ),
                  AppSpace.vertical.space20,
                  _SuggestionField<Country>(
                    controller: _countryController,
                    labelText: AppString.country,
                    getSuggestionMethod: (pattern) =>
                        _getSuggestionsFromCollection(
                            pattern: pattern,
                            collectionString: 'countries',
                            fromJson: Country.fromJson),
                  ),
                  AppSpace.vertical.space20,
                  _SuggestionField<City>(
                    controller: _cityController,
                    labelText: AppString.city,
                    getSuggestionMethod: (pattern) =>
                        _getSuggestionsFromSubCollection(
                            pattern: pattern,
                            parentDocumentName: _countryController.text.trim(),
                            parentCollectionString: 'countries',
                            subCollectionString: 'cities',
                            fromJson: City.fromJson),
                  ),
                  AppSpace.vertical.space20,
                  _SuggestionField<Employee>(
                    controller: _employeeController,
                    labelText: AppString.agent,
                    getSuggestionMethod: (pattern) =>
                        _getSuggestionsFromCollection(
                            pattern: pattern,
                            collectionString: 'employees',
                            fromJson: Employee.fromJson),
                    onSuggestionSelected: (employee) {
                      selectedEmployee = employee;
                      _employeeController.text =
                          employee?.name ?? 'Çalışan ismi alınamadı';
                    },
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
                        onPressed: () async {
                          final ValidationProvider validationProvider =
                              Provider.of<ValidationProvider>(context,
                                  listen: false);
                          final selectedProductList = context
                              .read<SelectedProductProvider>()
                              .selectedProducts;
                          //When the button is pressed, auto validation will be active on all fields
                          validationProvider.activateAllValidations();

                          //if validation is successful and user selected at least one product, a mission will be formed
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate() &&
                              selectedProductList.isNotEmpty) {
                            final Mission mission = Mission(
                              id: const Uuid().v4(),
                              date: _dateController.text.trim(),
                              market: _marketController.text.trim(),
                              company: _companyController.text.trim(),
                              products: context
                                  .read<SelectedProductProvider>()
                                  .selectedProducts
                                  .map((product) => product.name ?? '')
                                  .toList(),
                              city: _cityController.text.trim(),
                              country: _countryController.text.trim(),
                              isCompleted: false,
                              timestamp: DateTime.now(),
                              notes: _noteController.text.trim(),
                            );
                            try {
                              //user can select employee from dropdown list or write employee's name themselves. If they don't write the employee name correctly, the id of the employee cannot be retrieved. employeeId variable will handle that situation.
                              String? employeeId;

                              if (selectedEmployee?.id != null) {
                                //If user selects employee from dropdown list, the id of the employee will come with the selection and be assigned to employeeId, which will later be used to save the mission on database
                                employeeId = selectedEmployee!.id!;
                              } else {
                                //If user writes the employee name themselves, the employee id will be attempted to be retrieved from the database using the employee's name
                                final querySnapshot = await FirebaseFirestore
                                    .instance
                                    .collection('employees')
                                    .where('name',
                                        isEqualTo:
                                            _employeeController.text.trim())
                                    .get();
                                final employeeList = querySnapshot.docs
                                    .map((snapshot) =>
                                        Employee.fromJson(snapshot.data()))
                                    .toList();
                                //If the user wrote the employee name correctly, the employee's id will be assigned to employeeId variable. Otherwise employeeId will still be null.
                                if (employeeList.isNotEmpty) {
                                  employeeId = employeeList.first.id;
                                }
                              }
                              //If the user writes the name of the employee correctly or selects the employee from the dropdown list, the mission will be saved to database
                              if (employeeId != null) {
                                await FirebaseFirestore.instance
                                    .collection('employees')
                                    .doc(employeeId)
                                    .collection('missions')
                                    .doc(mission.id)
                                    .set(mission.toJson());
                                _clearAllFields();
                                validationProvider.deactivateAllValidations();

                                //If user did not choose the employee from the dropdown list and wrote employee's name wrong, an error snack bar will be shown
                              } else {
                                if (context.mounted) {
                                  _showErrorSnackBar(
                                      context: context,
                                      text: AppString.employeeNotFound);
                                }
                              }
                            } catch (_) {
                              //TODO: handle errors
                            }
                          }

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

  /// Retrieves a list of suggestions from a Firebase Firestore collection based on a given pattern.
  ///
  /// This method queries the specified Firestore collection for documents whose 'name' field
  /// is greater than or equal to the provided [pattern] and less than the [pattern] followed by 'z'.
  ///
  /// The retrieved data is then transformed using the [fromJson] function, which converts the raw
  /// JSON data of the model from the database into a list of entities.
  ///
  /// The resulting list is filtered based on the [pattern], and only relevant suggestions are returned.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// final List<YourModel> suggestions = await _getSuggestionsFromCollection<YourModel>(
  ///   pattern: 'searchPattern',
  ///   collectionString: 'yourCollectionName',
  ///   fromJson: (data) => YourModel.fromJson(data),
  /// );
  /// ```
  ///
  /// Parameters:
  /// - [pattern]: The search pattern to filter the suggestions.
  /// - [collectionString]: The name of the Firestore collection to query.
  /// - [fromJson]: A function to convert raw JSON data into model entities.
  ///
  /// Returns a list of suggestions based on the pattern.
  FutureOr<Iterable<T>>
      _getSuggestionsFromCollection<T extends ISuggestionModel>(
          {required String pattern,
          required String collectionString,
          required T Function(Map<String, dynamic>) fromJson}) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(collectionString)
          .where('name', isGreaterThanOrEqualTo: pattern.toLowerCase())
          .where('name', isLessThan: '${pattern.toLowerCase()}\uf8ff')
          .get();

      return querySnapshot.docs
          .map((doc) => fromJson(doc.data()))
          .where((entity) {
        final entityNameLower = entity.name?.toLowerCase();
        final patternLower = pattern.toLowerCase();
        return entityNameLower?.contains(patternLower) ?? false;
      }).toList();
    } catch (_) {
      return [];
    }
  }

  /// Retrieves a list of suggestions from a Firebase Firestore subcollection based on a given pattern.
  ///
  /// This method queries a specific subcollection within a Firestore document for documents whose 'name' field
  /// is greater than or equal to the provided [pattern] and less than the [pattern] followed by 'z'.
  ///
  /// The retrieved data is then transformed using the [fromJson] function, which converts the raw
  /// JSON data of the model from the database into a list of entities.
  ///
  /// The resulting list is filtered based on the [pattern], and only relevant suggestions are returned.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// final List<YourModel> suggestions = await _getSuggestionsFromSubCollection<YourModel>(
  ///   pattern: 'searchPattern',
  ///   parentDocumentName: 'yourParentDocumentName',
  ///   parentCollectionString: 'yourParentCollectionName',
  ///   subCollectionString: 'yourSubCollectionName',
  ///   fromJson: (data) => YourModel.fromJson(data),
  /// );
  /// ```
  ///
  /// Parameters:
  /// - [pattern]: The search pattern to filter the suggestions.
  /// - [parentDocumentName]: The name of the parent document that contains the subcollection to query.
  /// - [parentCollectionString]: The name of the Firestore collection containing the parent document.
  /// - [subCollectionString]: The name of the subcollection within the parent document to query.
  /// - [fromJson]: A function to convert raw JSON data into model entities.
  ///
  /// Returns a list of suggestions based on the pattern or an empty list if an error occurs during retrieval.
  FutureOr<Iterable<T>>
      _getSuggestionsFromSubCollection<T extends ISuggestionModel>(
          {required String pattern,
          required String parentDocumentName,
          required String parentCollectionString,
          required String subCollectionString,
          required T Function(Map<String, dynamic>) fromJson}) async {
    try {
      final String? docId = await getDocumentIdFromCollection(
          collectionString: parentCollectionString,
          fieldNameToBeQueried: 'name',
          searchPattern: parentDocumentName);

      final querySnapshot = await FirebaseFirestore.instance
          .collection(parentCollectionString)
          .doc(docId)
          .collection(subCollectionString)
          .where('name', isGreaterThanOrEqualTo: pattern.toLowerCase())
          .where('name', isLessThan: '${pattern.toLowerCase()}\uf8ff')
          // .orderBy('name')
          // .limit(20)
          .get();

      return querySnapshot.docs
          .map((doc) => fromJson(doc.data()))
          .where((entity) {
        final entityNameLower = entity.name?.toLowerCase();
        final patternLower = pattern.toLowerCase();
        return entityNameLower?.contains(patternLower) ?? false;
      }).toList();
    } catch (_) {
      return [];
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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
      children: [
        Icon(
          Icons.error_outline,
          color: context.errorColor,
        ),
        AppSpace.horizontal.space10,
        Expanded(
          child: Text(
            text,
          ),
        ),
      ],
    )));
  }

  void _clearAllFields() {
    _dateController.clear();
    _marketController.clear();
    _companyController.clear();
    _productController.clear();
    _countryController.clear();
    _cityController.clear();
    _noteController.clear();
    _employeeController.clear();
    selectedEmployee = null;
    context.read<SelectedProductProvider>().clearSelectedProductsList();
  }
}
