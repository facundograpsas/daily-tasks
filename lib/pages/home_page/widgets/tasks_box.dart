
import 'package:daily_tajsks/pages/home_page/widgets/done_tile.dart';
import 'package:daily_tajsks/pages/home_page/widgets/not_done_tile.dart';
import 'package:daily_tajsks/task/task_cubit.dart';
import 'package:daily_tajsks/task/task_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksBox extends StatefulWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  TasksBox() : super();

  _TasksBoxState createState() => _TasksBoxState();
}

class _TasksBoxState extends State<TasksBox> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(builder: (context, state) {
      if (state is TaskInitial) {
    return  CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent)
    );
      } else {
        if(state is TaskAdded){ widget._scrollController.jumpTo(widget._scrollController.position.maxScrollExtent);}
    return Flexible(
      child: ListView(
          controller: widget._scrollController,
          children: <Widget>[
            for(final task in state.tasks)
              if(task.done == 0)
                NotDoneTile(task: task)
              else
                DoneTile(task: task)
          ]
      ),
    );
      }

    });
  }
}
