import 'package:flutter/cupertino.dart';

class ValidationProvider extends ChangeNotifier {
  bool showValidation = false;
  bool isDateValid = false;
  bool isMarketValid = false;
  bool isProductListValid = false;
  bool isCountryValid = false;
  bool isCityValid = false;
  bool isEmployeeValid = false;

  void validateIfFieldIsEmpty({
    required String? input,
    required bool validationVariable,
  }) {
    if (input != null && input.isNotEmpty) {
      validationVariable = true;
    } else {
      validationVariable = false;
    }
    notifyListeners();
  }

  void activateAllValidations() {
    showValidation = true;
    notifyListeners();
  }

  void activateFieldValidation({
    required String? input,
    required Function(bool) updateFieldValidator,
  }) {
    bool fieldValidatorValue = false;
    if (input != null && input.isNotEmpty) {
      fieldValidatorValue = true;
    }
    updateFieldValidator(fieldValidatorValue);
    notifyListeners();
  }
}
