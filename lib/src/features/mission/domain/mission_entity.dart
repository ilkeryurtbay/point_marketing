import 'package:flutter/foundation.dart';
import 'package:point_marketing/src/features/admin/domain/entity/product_entity.dart';

@immutable
class Mission {
  final String date;
  final String marketName;
  final List<Product> products;
  final String city;
  final String country;
  final String assignedEmployee;

  const Mission({
    required this.date,
    required this.marketName,
    required this.products,
    required this.assignedEmployee,
    required this.city,
    required this.country,
  });

  factory Mission.fromJson(Map<String, dynamic> json) =>
      //TODO: Update when Firestore is ready
      Mission(
        date: json['date'],
        marketName: json['market_name'],
        products: json['products'],
        assignedEmployee: json['assigned_employee'],
        city: json['city'],
        country: json['country'],
      );

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'market_name': marketName,
      'products': products.map((product) => product.toJson()).toList(),
      'city': city,
      'country': country,
      'assigned_agent_name': assignedEmployee,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Mission &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          marketName == other.marketName &&
          city == other.city &&
          country == other.country &&
          assignedEmployee == other.assignedEmployee &&
          listEquals(products, other.products);

  @override
  int get hashCode =>
      date.hashCode ^
      marketName.hashCode ^
      city.hashCode ^
      country.hashCode ^
      assignedEmployee.hashCode ^
      products.hashCode;

  @override
  String toString() {
    return 'Mission{date: $date, marketName: $marketName, products: $products, city: $city, country: $country, assignedAgentName: $assignedEmployee}';
  }
}
