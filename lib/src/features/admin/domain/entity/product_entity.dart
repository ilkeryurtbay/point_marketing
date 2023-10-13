import 'package:flutter/material.dart';

import '../../domain/i_suggestion_model.dart';

@immutable
class Product implements ISuggestionModel {
  @override
  final String? name;
  const Product({required this.name});

  factory Product.fromJson(Map<String, dynamic> json) =>
      //TODO: Update when Firestore is ready
      Product(
        name: json['id'].toString(),
      );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => 'Product{name: $name}';
}
