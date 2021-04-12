
import 'package:daily_tajsks/task/task_cubit.dart';
import 'package:daily_tajsks/task/task_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksBox extends StatefulWidget {
   final tasksList;

  @override
    TasksBox({this.tasksList}) : super();

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
                  key: ValueKey(state.tasks?[index]),
                  children: [
                    Dismissible(
                      child: ListTile(
                        title: (Text(state.tasks[index].text,
                        style: TextStyle(decoration: TextDecoration.lineThrough, decorationColor: Colors.grey),)),
                        onTap: (){},
                        trailing: Icon(Icons.hourglass_top_rounded),
                      ),
                      key: ValueKey(state.tasks[index]),
                      background: Container(
                        color: Color(0xff842121),
                      ),
                      onDismissed: (DismissDirection direction) {
                        context.read<TaskCubit>().deleteTask(state.tasks[index]);
                      },
                    ),
                    Divider(
                      thickness: 0.5,
                      indent: 20,
                      endIndent: 20,
                    )
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


