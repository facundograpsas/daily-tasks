
import 'package:daily_tajsks/pages/home_page/widgets/custom_textfield.dart';
import 'package:daily_tajsks/pages/home_page/widgets/tasks_box.dart';
import 'package:daily_tajsks/task/task.dart';
import 'package:daily_tajsks/task/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  HomeView({required this.title}) : super();

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
        backgroundColor: Color(0xfffff9df),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => context.read<TaskCubit>().deleteAll()
            )
          ],
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Flexible(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                TasksBox()])),
                Row(children: [
              Expanded(
                child: CircularRadiusShadowTextField(myController: myController),
              ),
              IconButton(
                icon: Icon(Icons.send),
                color: Colors.redAccent,
                iconSize: 40,
                onPressed: () {
                  if(myController.text.isNotEmpty){
                    context
                        .read<TaskCubit>()
                        .addTask(Task(text: myController.text));
                    myController.clear();
                  }
                }
              )
                ])
              ]),
            );
  }
}

