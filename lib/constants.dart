import 'package:flutter/material.dart';
import 'package:todoist_clone_app/data/todo.dart';

class ColorPallete {
  static const black = Color(0xFF242323);
  static const blackLight = Color(0xFF393838);
  static const red = Color(0xFFCD3608);
  static const grey = Color(0xFFC2C2C2);
  static const white = Color(0xFFFFFFEF);
}

class DummyData {
  static final taskLists = [
    Todo(title: 'Task 1', description: 'Description 1'),
    Todo(title: 'Task 2', description: 'Description 2'),
    Todo(title: 'Task 3', description: 'Description 3'),
    Todo(title: 'Task 4', description: 'Description 4'),
    Todo(title: 'Task 5', description: 'Description 5'),
    Todo(title: 'Task 6', description: 'Description 6'),
    Todo(title: 'Task 7', description: 'Description 7'),
  ];
}
