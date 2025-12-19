import 'package:flutter/material.dart';

class ElectionType {
  final String id;
  final String type;
  final String title;
  final String description;
  final IconData icon;
  final DateTime startDate;
  final DateTime endDate;
  final bool isOpen;
  final Color color;

  ElectionType({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.icon,
    required this.startDate,
    required this.endDate,
    required this.isOpen,
    required this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'isOpen': isOpen,
    };
  }

  factory ElectionType.fromJson(Map<String, dynamic> json) {
    return ElectionType(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      description: json['description'],
      icon: Icons.how_to_vote, // Default icon, you might want to map this
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      isOpen: json['isOpen'],
      color: Colors.blue, // Default color, you might want to map this
    );
  }
}