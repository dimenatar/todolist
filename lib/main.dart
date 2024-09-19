import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_second/bloc/TaskBloc.dart';
import 'package:todo_list_second/bloc/note_event.dart';
import 'package:todo_list_second/models/firebase_manager.dart';
import 'package:todo_list_second/screens/create_task_screen.dart';
import 'package:todo_list_second/screens/edit_task_screen.dart';
import 'package:todo_list_second/screens/tasks_list_screen.dart';

void main() {

  runApp(const MyApp(

  ));
}

class MyApp extends StatelessWidget {



  const MyApp({super.key});

  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {

    FirebaseManager m = FirebaseManager();
    m.getTasks();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => TaskBloc()..add(LoadEvent()),
        ),
      ],
      child: MaterialApp(
       routes:
       {
         'edit_task_screen': (context) => EditTaskScreen(),
         'create_task_screen': (context) => CreateTaskScreen(),
       },
      home: TodoListScreen(),
      ),
    );

  }
}