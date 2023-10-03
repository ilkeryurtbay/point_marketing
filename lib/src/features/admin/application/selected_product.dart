import 'package:flutter/material.dart';

import '../data/entity/product_entity.dart';

class SelectedProduct extends ChangeNotifier {
  late Product? selectedProduct;
  List<Product> selectedProducts = [];

  void addSelectedProductToList() {
    if (selectedProduct != null) {
      selectedProducts.add(selectedProduct!);
      notifyListeners();
    }
  }

  void removeProductFromList(Product product) {
    selectedProducts.remove(product);
    notifyListeners();
  }
}
