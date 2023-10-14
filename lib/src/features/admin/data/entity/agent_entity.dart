import '../../domain/i_suggestion_model.dart';

class employe implements ISuggestionModel {
  @override
  final String? name;
  employe({required this.name});

  factory employe.fromJson(Map<String, dynamic> json) =>
      //TODO: Update when Firestore is ready
      employe(name: json['title']);
}
