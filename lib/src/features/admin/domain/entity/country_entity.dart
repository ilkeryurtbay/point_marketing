import 'package:point_marketing/src/features/admin/domain/i_suggestion_model.dart';

class Country implements ISuggestionModel {
  @override
  final String name;
  Country({required this.name});

  factory Country.fromJson(
          Map<String, dynamic>
              //TODO: Update when Firestore is ready
              json) =>
      Country(name: json['title']);
}
