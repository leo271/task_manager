import 'package:flutter/material.dart';
import 'package:task_manager/home_page/task_state.dart';

class TaskCreateModal extends StatefulWidget {
  const TaskCreateModal({Key? key, required this.addTask}) : super(key: key);
  final void Function(TaskState task) addTask;

  @override
  State<StatefulWidget> createState() => _TaskCreateModalState();
}

class _TaskCreateModalState extends State<TaskCreateModal> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextField(
            autofocus: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            onSubmitted: (value) {
              widget.addTask(TaskState(title: value));
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
