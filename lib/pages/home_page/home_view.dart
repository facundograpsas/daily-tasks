import 'dart:developer';

import 'package:daily_tajsks/task_state.dart';
import 'package:daily_tajsks/pages/home_page/widgets/tasks_box.dart';
import 'package:daily_tajsks/task.dart';
import 'package:daily_tajsks/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Task> _tasksList = [];
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
              TasksBox(
                tasksList: _tasksList,
              ),
              Text("$taps Taps"),
              Container(
                  height: 300,
                  child: BlocBuilder<TaskCubit, TaskState>(
                      builder: (context, state) {
                    if (state is TaskInitial) {
                      return Container(
                        height: 60.0,
                        child: new Center(child: new CircularProgressIndicator()),
                      );
                    } else {
                      return
                        ReorderableListView.builder(itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            key:ValueKey(state.tasks[index]),
                            title:(Text(state.tasks[index].text)),
                            subtitle: Text(index.toString()+ " ID:"+state.tasks[index].id.toString()+"  INDEX:"+state.tasks[index].taskIndex.toString()),

                          );
                        },
                            itemCount: state.tasks.length,
                        onReorder: (oldIndex, newIndex){
                          context.read<TaskCubit>().updateList(oldIndex, newIndex);
                        });
                    }
                  })),
              Row(children: [
                Expanded(
                  child: TextField(
                    controller: myController,
                  ),
                ),
                ElevatedButton(
                  child: Text("Enviar"),
                  onPressed: () => context
                      .read<TaskCubit>()
                      .addTask(Task(text: myController.text)),
                )
              ])
            ])) // This trailing comma makes auto-formatting nicer for build methods.
            );
  }
}
