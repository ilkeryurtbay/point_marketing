import '../../domain/i_suggestion_model.dart';

class Employee implements ISuggestionModel {
  @override
  final String? name;
  Employee({required this.name});

  factory Employee.fromJson(Map<String, dynamic> json) =>
      //TODO: Update when Firestore is ready
      Employee(name: json['title']);
}
