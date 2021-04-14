import 'package:daily_tajsks/task/task.dart';
import 'package:daily_tajsks/task/task_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoneTile extends StatefulWidget {

  final Task task;

  @override
  DoneTile({required this.task}) : super();

  @override
  _DoneTileState createState() => _DoneTileState();
}

class _DoneTileState extends State<DoneTile> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      child: Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12)),
        color: Color(0xffb66868)),
        child: ListTile(
          tileColor: Color(0xffb66868),
          onLongPress: () => context.read<TaskCubit>().taskDone(widget.task),
          key: ValueKey(widget.task),
          title: (Text(
            widget.task.text,
            style: TextStyle(
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.grey),
          )),
          subtitle: Text("Done!"),
          onTap: () {},
          trailing: Icon(Icons.done,
          color: Colors.redAccent,),
        ),
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