import 'package:flutter/foundation.dart';

@immutable
class Mission {
  final String? id;
  final String? date;
  final String? market;
  final String? company;
  final List<String>? products;
  final String? city;
  final String? country;
  final bool? isCompleted;
  final DateTime? timestamp;
  final String? notes;

  const Mission({
    required this.id,
    required this.date,
    required this.market,
    required this.company,
    required this.products,
    required this.city,
    required this.country,
    required this.isCompleted,
    required this.timestamp,
    this.notes,
  });

  factory Mission.fromJson(Map<String, dynamic> json) =>
      //TODO: Update when Firestore is ready
      Mission(
        id: json['id'],
        date: json['date'],
        market: json['market'],
        company: json['company'],
        products: json['products'],
        city: json['city'],
        country: json['country'],
        isCompleted: json['is_completed'],
        timestamp: json['timestamp'],
        notes: json['notes'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'market': market,
      'company': company,
      'products': products,
      'city': city,
      'country': country,
      'is_completed': isCompleted,
      'timestamp': timestamp,
      'notes': notes,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Mission &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          date == other.date &&
          market == other.market &&
          city == other.city &&
          country == other.country &&
          company == other.company &&
          timestamp == other.timestamp &&
          listEquals(products, other.products);

  @override
  int get hashCode =>
      id.hashCode ^
      date.hashCode ^
      market.hashCode ^
      city.hashCode ^
      country.hashCode ^
      company.hashCode ^
      isCompleted.hashCode ^
      timestamp.hashCode;

  @override
  String toString() {
    return 'Mission{id: $id, date: $date, marketName: $market, company: $company, products: $products  city: $city, country: $country, isCompleted: $isCompleted, timestamp: $timestamp, notes: $notes,}';
  }
}
