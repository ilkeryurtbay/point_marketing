import '../../domain/i_suggestion_model.dart';

class Company implements ISuggestionModel {
  @override
  final String? name;
  Company({required this.name});

  factory Company.fromJson(Map<String, dynamic> json) =>
      //TODO: Update when Firestore is ready
      Company(name: json['title']);
}
