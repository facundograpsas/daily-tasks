import 'package:flutter/material.dart';

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
        child :FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 0.5,
          child: Container(
            child: Column(
              children: [
                Text("asd")
              ],
            ),
            color: Colors.white70,
          ),
        )
    )
    ;
  }
}




