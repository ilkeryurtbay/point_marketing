import 'package:point_marketing/src/features/admin/domain/i_suggestion_model.dart';

class City implements ISuggestionModel {
  @override
  final String name;

  City({required this.name});

  factory City.fromJson(
          Map<String, dynamic>
              //TODO: Update when Firestore is ready
              json) =>
      City(name: json['title']);
}
