class Task {
  String id;
  String name;
  String description;
  String date;
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
        date: json['date'] ?? '',
        time: json['time'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'date': date,
        'time': time,
      };
}
