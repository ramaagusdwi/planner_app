import 'package:flutter_application_planner/task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskNotifier
    extends StateNotifier<List<Task>> {
  TaskNotifier({required List<Task> tasks})
      : super(tasks);

  void toggle(int taskId) {
    state = [
      for (final item in state)
        if (taskId == item.id)
          item.copyWith(
              completed: !item.completed)
        else
          item
    ];
  }
}
