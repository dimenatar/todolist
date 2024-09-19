import 'package:todo_list_second/models/task_model.dart';

abstract class TaskEvent{

}

class LoadEvent implements TaskEvent{
}

class AddEvent implements TaskEvent{
  final Task task;

  const AddEvent(this.task);
}

class UpdateEvent implements TaskEvent{
  final Task task;

  const UpdateEvent(this.task);
}

class DeleteEvent implements TaskEvent{
  final Task task;

  const DeleteEvent(this.task);
}