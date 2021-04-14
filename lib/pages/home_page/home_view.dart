
import 'dart:async';

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
  final ScrollController _scrollController = ScrollController();

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
                TasksBox(scrollController: _scrollController)])),
                Row(children: [
              Flexible(
                child: CircularRadiusShadowTextField(editTextController: myController),
              ),
              IconButton(
                icon: Icon(Icons.send),
                color: Colors.redAccent,
                iconSize: 40,
                onPressed: () async {
                  if(myController.text.isNotEmpty){
                    context.read<TaskCubit>().addTask(Task(text: myController.text));
                    myController.clear();
                    await Future.delayed(Duration(milliseconds: 200));
                    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                  }
                }
              )
                ])
              ]),
            );
  }
}

