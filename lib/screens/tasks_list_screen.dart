import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_second/bloc/TaskBloc.dart';

import '../bloc/task_state.dart';
import '../models/task_model.dart';
import '../widgets/task_tile.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
/*  List<Task>
  tasks = [
    Task(id: "0", title: 'How to make your personal brand stand out online', date: DateTime(2020, 5, 21)),
  ];*/

  void taskClicked(Task task) async
  {
    var result = await Navigator.pushNamed(context, 'edit_task_screen', arguments: {'task': task}) as Task;
/*    setState(() {
      task.text = result.text;
      task.date = result.date;
      task.title = result.title;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),

            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),


      body:  BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        var tasks = <Task>[];

        print(state);

        if (state is TaskLoadedState)
          {
            tasks = state.tasks;
          }

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,

          ),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return InkWell(
                child: IgnorePointer(
                    child: TaskTile(task: tasks[index])
                ),
                onTap:()
                {
                  taskClicked(tasks[index]);
                }
            );
          },
        );
      },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.pushNamed(context, 'create_task_screen');
          /*if (result is Task)
          {
            setState(() {
              Task task = result;
              task.id = tasks.length.toString();
              tasks.add(task);
            });
          }*/
        },
        child: Icon(Icons.add),
      ),
    );
  }
}