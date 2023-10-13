import 'package:flutter/foundation.dart';
import 'package:point_marketing/src/features/admin/domain/entity/product_entity.dart';

import '../../domain/i_suggestion_model.dart';

class Company implements ISuggestionModel {
  @override
  final String? name;
  final List<Product>? products;
  Company({
    required this.name,
    required this.products,
  });

  factory Company.fromJson(Map<String, dynamic> json) =>
      //TODO: Update when Firestore is ready
      Company(name: json['name'], products: json['products']);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Company &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          listEquals(products, other.products);

  @override
  String toString() => 'Company{name: $name, products: $products}';

  @override
  int get hashCode {
    int hash = name.hashCode;
    if (products != null) {
      for (final product in products!) {
        hash ^= product.hashCode;
      }
    }
    return hash;
  }
}
