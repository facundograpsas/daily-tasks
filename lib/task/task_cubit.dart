import 'dart:developer';

import 'package:daily_tajsks/task/db.dart';
import 'package:daily_tajsks/task/task.dart';
import 'package:daily_tajsks/task/task_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskCubit extends Cubit<TaskState>{

  List<Task>? _tasksList;

  TaskCubit() : super(TaskInitial()){
    loadTasks();
  }

  @override
  void onChange(Change<TaskState> change) {
    log(change.toString());
    super.onChange(change);
  }


  void loadTasks() async {
    await Future.delayed(Duration(seconds: 2));
    final tasksMap = await TasksDatabase.instance.queryAllRows();
    _tasksList = tasksMap.map((task) =>
       Task(text: task["text"].toString(),
            id: task["id"],
            done: task["done"]
    )).toList();

    emit(TasksLoaded(_tasksList!));
  }



  void addTask(Task task) async {
    emit(TaskUpdate(_tasksList!));
    var id = await TasksDatabase.instance.insert(task);
    var taskMap = await TasksDatabase.instance.get(id);
    _tasksList!.insert(0, Task(text: taskMap["text"].toString(), id: taskMap["id"], done: taskMap["done"]));
    emit(TasksLoaded(_tasksList!));
  }


  void updateList(int oldIndex, int newIndex) async {
    emit(TaskUpdate(_tasksList!));
    var task = _tasksList!.elementAt(oldIndex);
    _tasksList!.removeAt(oldIndex);

    if (newIndex<oldIndex)  {_tasksList!.insert(newIndex, task);}
    else { _tasksList!.insert(newIndex-1, task); }

    emit(TasksLoaded(_tasksList!));
  }

  deleteAll() async {
    await TasksDatabase.instance.clearTable();
    _tasksList!.clear();
    emit(TaskCleared());
  }

  void deleteTask(Task task) async {
    await TasksDatabase.instance.delete(task.id!);
    _tasksList!.remove(task);
    emit(TaskUpdate(_tasksList!));
    emit(TasksLoaded(_tasksList!));

  }

  taskDone(Task task) async {
    emit(TaskUpdate(_tasksList!));
    Task tempTask = task;
    tempTask.done = 1;
    await TasksDatabase.instance.updateTask(task);
    _tasksList![_tasksList!.indexWhere((element) => element.id == tempTask.id)] = tempTask;
    emit(TaskDone(_tasksList!));
  }

}