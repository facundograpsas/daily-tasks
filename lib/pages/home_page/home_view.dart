import 'dart:developer';

import 'package:daily_tajsks/pages/home_page/widgets/custom_textfield.dart';
import 'package:daily_tajsks/pages/home_page/widgets/tasks_box.dart';
import 'package:daily_tajsks/task/task.dart';
import 'package:daily_tajsks/task/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int taps = 0;

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(children: [
          TasksBox(),
          Row(children: [
            Expanded(
              child: CircularRadiusShadowTextField(myController: myController),
            ),
            ElevatedButton(
              child: Icon(Icons.send),
              onPressed: () {
                context
                    .read<TaskCubit>()
                    .addTask(Task(text: myController.text));
                myController.clear();
              }
            )
          ])
        ])) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

