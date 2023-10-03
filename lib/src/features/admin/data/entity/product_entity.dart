import '../../domain/i_suggestion_model.dart';

class Product implements ISuggestionModel {
  @override
  final String? name;
  final String? companyName;
  Product({required this.name, required this.companyName});

  factory Product.fromJson(Map<String, dynamic> json) =>
      //TODO: Update when Firestore is ready
      Product(
        name: json['title'],
        companyName: json['company'],
      );
}
