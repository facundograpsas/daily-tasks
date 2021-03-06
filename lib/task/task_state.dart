import 'package:daily_tajsks/task/task.dart';
import 'package:equatable/equatable.dart';

abstract class TaskState extends Equatable{
  const TaskState();
  List<Object> get props => [];
  get tasks => [];
}

class TaskInitial extends TaskState{

}

class TasksLoaded extends TaskState{
  final List<Task> tasks;
  TasksLoaded(this.tasks);
}

class TaskUpdate extends TaskState{
  final List<Task> tasks;
  TaskUpdate(this.tasks);
}

class TaskCleared extends TaskState{
}

class TaskDone extends TaskState{
  final List<Task> tasks;
  TaskDone(this.tasks);
}

class TaskAdded extends TaskState{
  final List<Task> tasks;
  TaskAdded(this.tasks);
}
