import 'package:point_marketing/src/features/admin/data/entity/product_entity.dart';

class Mission {
  final String date;
  final String marketName;
  final List<Product> products;

  Mission({
    required this.date,
    required this.marketName,
    required this.products,
  });

  factory Mission.fromJson(Map<String, dynamic> json) =>
      //TODO: Update when Firestore is ready
      Mission(
        date: json['date'],
        marketName: json['market_name'],
        products: json['products'],
      );
}
