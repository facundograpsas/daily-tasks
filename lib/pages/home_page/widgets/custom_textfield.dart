import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CircularRadiusShadowTextField extends StatelessWidget {
  const CircularRadiusShadowTextField({
    Key key,
    @required this.myController,
  }) : super(key: key);

  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white70,
            // border: Border.all(width: 0),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0,3)
              )
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Write your task here...",
            ),
            controller: myController,
          ),
        ),
      ),
    );
  }
}
