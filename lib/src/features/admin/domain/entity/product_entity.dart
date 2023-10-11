import 'package:flutter/material.dart';

import '../../domain/i_suggestion_model.dart';

@immutable
class Product implements ISuggestionModel {
  @override
  final String? name;
  final String? companyName;
  const Product({required this.name, required this.companyName});

  factory Product.fromJson(Map<String, dynamic> json) =>
      //TODO: Update when Firestore is ready
      Product(
        name: json['id'].toString(),
        companyName: json['body'],
      );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'companyName': companyName,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          companyName == other.companyName;

  @override
  int get hashCode => name.hashCode ^ companyName.hashCode;

  @override
  String toString() => 'Product{name: $name, company name: $companyName}';
}
