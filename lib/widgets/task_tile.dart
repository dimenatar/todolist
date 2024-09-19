import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import '../models/task_model.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  TaskTile({required this.task});

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile>
{
  @override
  Widget build(BuildContext context) {
    return
      ListTile(
        title: Text(widget.task.title),
        subtitle: Text(intl.DateFormat('MMM dd, yyyy').format(widget.task.date.toDate())),
      );
  }
}