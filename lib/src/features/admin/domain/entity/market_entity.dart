import '../../domain/i_suggestion_model.dart';

class Market implements ISuggestionModel {
  @override
  final String? name;
  Market({required this.name});

  factory Market.fromJson(Map<String, dynamic> json) =>
      //TODO: Update when Firestore is ready
      Market(name: json['title']);
}
