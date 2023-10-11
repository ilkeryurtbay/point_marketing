import 'package:flutter/material.dart';

import '../../domain/i_suggestion_model.dart';

@immutable
class Employee implements ISuggestionModel {
  @override
  final String? name;
  final String? employeeId;
  const Employee({
    required this.name,
    required this.employeeId,
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      //TODO: Update when Firestore is ready
      Employee(name: json['title'], employeeId: json['employee_id']);
}
