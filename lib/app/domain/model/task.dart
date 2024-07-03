import 'package:intl/intl.dart';

class Task {
  String id;
  String name;
  String description;
  DateTime date;
  String time;

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.time,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        date: DateFormat("dd/MM/yyyy").parse(json['date']),
        time: json['time'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'date':
            "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString().padLeft(4, '0')}",
        'time': time,
      };
}
