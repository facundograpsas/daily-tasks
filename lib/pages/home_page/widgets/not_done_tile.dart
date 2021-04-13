import 'package:daily_tajsks/task/task.dart';
import 'package:daily_tajsks/task/task_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotDoneTile extends StatefulWidget {

  final Task task;

  @override
  NotDoneTile({required this.task}) : super();

  @override
  _NotDoneTileState createState() => _NotDoneTileState();
}

class _NotDoneTileState extends State<NotDoneTile> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      child: ListTile(
        onLongPress: () => context.read<TaskCubit>().taskDone(widget.task),
        key: ValueKey(widget.task),
        title: (Text(
          widget.task.text,
          style: TextStyle(
              decoration: TextDecoration.lineThrough,
              decorationColor: Colors.grey),
        )),
        subtitle: Text(widget.task.done.toString()),
        onTap: () {},
        trailing: Icon(Icons.hourglass_top_rounded),
      ),
      key: ValueKey(widget.task),
      background: Container(
        color: Color(0xff842121),
      ),
      onDismissed: (DismissDirection direction) {
        context.read<TaskCubit>().deleteTask(widget.task);
      },
    );
  }
}




