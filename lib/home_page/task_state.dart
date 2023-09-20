import 'package:flutter/material.dart';

class TaskState {
  String title;
  bool isDone;
  Color? color;
  DateTime? deadline;

  TaskState({
    required this.title,
    this.isDone = false,
    this.color,
    this.deadline,
  });
}
