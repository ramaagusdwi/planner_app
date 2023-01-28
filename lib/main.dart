import 'package:flutter/material.dart';
import 'package:flutter_application_planner/task.dart';
import 'package:flutter_application_planner/task_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

final tasksProvider = StateNotifierProvider<TaskNotifier, List<Task>>(
  (ref) {
    return TaskNotifier(tasks: [
      Task(id: 1, label: 'tugas pertama saya'),
      Task(id: 2, label: 'tugas kedua saya'),
      Task(id: 3, label: 'tugas ketiga saya'),
      Task(id: 4, label: 'tugas keempat saya'),
      Task(id: 5, label: 'tugas kelima saya'),
    ]);
  },
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Planner App')),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Progress(),
            const SizedBox(height: 40),
            const TaskList()
          ],
        ),
      ),
    );
  }
}

class Progress extends ConsumerWidget {
  const Progress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tasks = ref.watch(tasksProvider);

    var numCompletedTasks = tasks.where(((task) {
      return task.completed == true;
    })).length;

    return Column(
      children: [
        const Text('kamu sudah sejauh ini mengerjakan tugasmu wkwk'),
        const SizedBox(height: 4),
        LinearProgressIndicator(value: numCompletedTasks / tasks.length),
      ],
    );
  }
}

class TaskList extends ConsumerWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    return Column(children: tasks.map((task) => TaskItem(task: task)).toList());
  }
}

class TaskItem extends ConsumerWidget {
  final Task task;
  const TaskItem({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build

    return CheckboxListTile(
      tileColor: Colors.white,
      title: Text(task.label),
      value: task.completed,
      onChanged: (bool? value) {
        ref.read(tasksProvider.notifier).toggle(task.id);
      },
    );
  }
}

// class _TaskItemState extends State<TaskItem> {
//   bool _isSelected = true;
//   @override
//   Widget build(BuildContext context) {
//     return CheckboxListTile(
//       tileColor: Colors.white,
//       title: Text(widget.task.label),
//       value: _isSelected,
//       onChanged: (bool? value) {
//         setState(() {
//           _isSelected = value!;
//         });
//       },
//     );
//   }
// }
