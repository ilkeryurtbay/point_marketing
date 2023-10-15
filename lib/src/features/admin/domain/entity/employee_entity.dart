import 'package:flutter/material.dart';

import '../../domain/i_suggestion_model.dart';

@immutable
class Employee implements ISuggestionModel {
  @override
  final String? name;
  final String? id;
  const Employee({
    required this.name,
    required this.id,
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      //TODO: Update when Firestore is ready
      Employee(name: json['name'], id: json['id']);
}
