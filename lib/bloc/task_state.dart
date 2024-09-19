import '../models/task_model.dart';

abstract class TaskState{

}

class TaskInitialState implements TaskState{
  const TaskInitialState();
}

class TaskLoadedState implements TaskState{
  final List<Task> tasks;

  const TaskLoadedState(this.tasks);
}

class TaskAddedState implements TaskState{
  final Task task;

  const TaskAddedState(this.task);
}

class TaskUpdatedState implements TaskState{
  final Task task;

  const TaskUpdatedState(this.task);
}

class TaskRemovedState implements TaskState{
  final Task task;

  const TaskRemovedState(this.task);
}