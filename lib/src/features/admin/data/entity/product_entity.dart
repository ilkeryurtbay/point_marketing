import '../../domain/i_suggestion_model.dart';

class Product implements ISuggestionModel {
  @override
  final String? name;
  final String? companyName;
  Product({required this.name, required this.companyName});

  factory Product.fromJson(Map<String, dynamic> json) =>
      //TODO: Update when Firestore is ready
      Product(
        name: json['id'].toString(),
        companyName: json['body'],
      );

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
