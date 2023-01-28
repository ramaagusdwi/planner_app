// ignore_for_file: public_member_api_docs, sort_constructors_first
class Task {
  final int id;
  final String label;
  bool completed;

  Task({required this.id, required this.label, this.completed = false});

  Task copyWith({
    int? id,
    String? label,
    bool? completed,
  }) {
    return Task(
      id: id ?? this.id,
      label: label ?? this.label,
      completed: completed ?? this.completed,
    );
  }
}
