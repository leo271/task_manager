import 'package:flutter/material.dart';
import 'package:task_manager/home_page/task_state.dart';

class TaskList extends StatefulWidget {
  const TaskList({
    Key? key,
    required this.tasks,
    required this.toggleSelected,
  }) : super(key: key);
  final List<TaskState> tasks;
  final void Function(int index) toggleSelected;

  @override
  State<StatefulWidget> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ListView(
      shrinkWrap: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  color: colorScheme.secondary,
                )),
            Text("編集", style: TextStyle(color: colorScheme.secondary)),
            const SizedBox(width: 10),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.info, color: colorScheme.secondary)),
            Text("その他", style: TextStyle(color: colorScheme.secondary)),
          ],
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: colorScheme.surface),
          child: Column(children: [
            for (var index = 0; index < widget.tasks.length; index++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CheckboxListTile(
                  title: Text(widget.tasks[index].title,
                      style: TextStyle(
                          color: colorScheme.onSurface,
                          decoration: widget.tasks[index].isDone
                              ? TextDecoration.lineThrough
                              : null)),
                  value: widget.tasks[index].isDone,
                  onChanged: (bool? value) {
                    widget.toggleSelected(index);
                  },
                ),
              )
          ]),
        )
      ],
    );
  }
}
