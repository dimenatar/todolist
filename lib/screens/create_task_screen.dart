import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_second/bloc/TaskBloc.dart';
import 'package:todo_list_second/bloc/note_event.dart';

import '../bloc/task_state.dart';
import '../models/task_model.dart';

class CreateTaskScreen extends StatefulWidget {

  CreateTaskScreen();

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _captionController = TextEditingController();
  final _mainTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Task'),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state)
          {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _captionController,
                decoration: const InputDecoration(
                  labelText: 'Caption',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a caption';
                  }
                  return null;
                },
              ),
              new TextFormField(
                  controller: _mainTextController,
                  maxLines: 20,
                  decoration: const InputDecoration(
                    labelText: 'Main Text',
                  )
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final task = Task(
                      id: "",
                      title: _captionController.text,
                      date: DateTime.now(),
                      text: _mainTextController.text,
                    );

                    context.read<TaskBloc>().add(AddEvent(task));

                    Navigator.pop(context, task);
                  }
                },
                child: const Text('Create Task'),
              ),
            ],
          ),
        ),
      );
      },
    )
    );

  }
}