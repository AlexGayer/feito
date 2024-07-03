import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Task {
  String id;
  String name;
  String description;
  DateTime date;
  String time;
  String priority;

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.time,
    required this.priority,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        date: DateFormat("dd/MM/yyyy").parse(json['date']),
        time: json['time'] ?? '',
        priority: json['priority'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'date':
            "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString().padLeft(4, '0')}",
        'time': time,
        'priority': priority,
      };

  Color getPriorityColor() {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey; // Cor padrão ou outra cor padrão que desejar
    }
  }
}
