import 'dart:developer';

import 'package:daily_tajsks/pages/home_page/widgets/done_tile.dart';
import 'package:daily_tajsks/pages/home_page/widgets/not_done_tile.dart';
import 'package:daily_tajsks/task/task.dart';
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
    return BlocBuilder<TaskCubit, TaskState>(builder: (context, state) {
      if (state is TaskInitial) {
    return new CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.redAccent)
    );
      } else {
    return Flexible(
      child: ListView(
          children: [
            for (final task in state.tasks)
              if(task.done == 0)
                 NotDoneTile(task: task)
              else
                 DoneTile(task: task)
      ,
            Divider(
              key: ValueKey("task"),
              thickness: 0.5,
              indent: 20,
              endIndent: 20,
            )
          ]),
    );
      }
    });
  }


}
