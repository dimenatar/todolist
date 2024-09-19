import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_second/bloc/TaskBloc.dart';
import 'package:todo_list_second/bloc/note_event.dart';
import 'package:todo_list_second/bloc/task_state.dart';

import '../models/task_model.dart';

class EditTaskScreen extends StatefulWidget {

  Task? task;
  EditTaskScreen();

  @override
  _EditTaskScreen createState() => _EditTaskScreen();
}

class _EditTaskScreen extends State<EditTaskScreen> {

  final _captionController = TextEditingController();
  final _dateController = TextEditingController();
  final _mainTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();



  }

  @override
  Widget build(BuildContext context)
  {
    final Map data = ModalRoute.of(context)!.settings.arguments as Map;

    if (data.containsKey('task'))
    {
      widget.task = data['task'];
      _captionController.text = widget.task!.title;
      _dateController.text = DateFormat('MMM dd, yyyy').format(widget.task!.date);
      _mainTextController.text = widget.task!.text;
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),

            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>
        (
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
                    TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Date',
                      ),
                    ),
                    TextFormField(
                      controller: _mainTextController,
                      decoration: const InputDecoration(
                        labelText: 'Main Text',
                      ),
                      maxLines: 5,
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final updatedTask = Task(
                            id: widget.task!.id,
                            title: _captionController.text,
                            date: DateTime.now(),
                            text: _mainTextController.text,
                          );
                          context.read<TaskBloc>().add(UpdateEvent(updatedTask));
                          Navigator.pop(context, updatedTask);
                        }
                      },
                      child: const Text('Save Changes'),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );

  }
}