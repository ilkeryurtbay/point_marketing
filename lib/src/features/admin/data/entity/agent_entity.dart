import '../../domain/i_suggestion_model.dart';

class Agent implements ISuggestionModel {
  @override
  final String? name;
  Agent({required this.name});

  @override
  factory Agent.fromJson(Map<String, dynamic> json) =>
      //TODO: Update when Firestore is ready
      Agent(name: json['title']);
}
