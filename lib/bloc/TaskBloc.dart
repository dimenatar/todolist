import 'package:bloc/bloc.dart';
import 'package:todo_list_second/bloc/task_state.dart';
import 'package:todo_list_second/models/task_model.dart';

import 'note_event.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState>{
  TaskBloc() : super(const TaskInitialState())
  {
    on<LoadEvent>((event, emit) async{
      emit(const TaskLoadedState(<Task>[]));
    });
    on<AddEvent>((event, emit){
      if (state is TaskLoadedState)
        {
          final state = this.state as TaskLoadedState;
          emit(
            TaskLoadedState(
              List.from(state.tasks)..add(event.task),
            ),
          );
        }
    });
    on<UpdateEvent>((event, emit){
      if (state is TaskLoadedState)
      {
        final state = this.state as TaskLoadedState;
        final foundTask = state.tasks.where((t) => t.id == event.task.id).first;
        foundTask.title = event.task.title;
        foundTask.date = event.task.date;
        foundTask.text = event.task.text;

        emit(
          TaskLoadedState(
            state.tasks,
          ),
        );
      }
    });
    on<DeleteEvent>((event, emit){
      if (state is TaskLoadedState)
      {
        final state = this.state as TaskLoadedState;
        emit(
          TaskLoadedState(
            List.from(state.tasks)..remove(event.task),
          ),
        );
      }
    });
    }
}
