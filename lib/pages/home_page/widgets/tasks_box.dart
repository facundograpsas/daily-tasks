
import 'package:daily_tajsks/task/task_cubit.dart';
import 'package:daily_tajsks/task/task_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksBox extends StatefulWidget {
   final tasksList;

  @override
    TasksBox({Key key, this.tasksList}) : super(key: key);

  _TasksBoxState createState() => _TasksBoxState();
}

class _TasksBoxState extends State<TasksBox> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FractionallySizedBox(child:
      BlocBuilder<TaskCubit, TaskState>(builder: (context, state) {
        if (state is TaskInitial) {
          return Container(
            height: 60.0,
            child: new Center(child: new CircularProgressIndicator()),
          );
        } else {
          return ReorderableListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  key: ValueKey(state.tasks[index]),
                  children: [
                    ListTile(
                      title: (Text(state.tasks[index].text)),
                      subtitle: Text(index.toString() +
                          " ID:" +
                          state.tasks[index].id.toString()),
                    ),
                    Divider()
                  ],
                );
              },
              itemCount: state.tasks.length,
              onReorder: (oldIndex, newIndex) {
                context.read<TaskCubit>().updateList(oldIndex, newIndex);
              },
          );
        }
      })),
    );
  }
}


