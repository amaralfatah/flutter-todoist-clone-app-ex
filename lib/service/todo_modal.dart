import 'package:flutter/material.dart';
import 'package:todoist_clone_app/service/todo_shared_preferences.dart';

import '../data/todo.dart';

class TodoModal extends ChangeNotifier {
  late TodoSharedPreferences _todoSharedPreferences;

  TodoModal() {
    _todoSharedPreferences = TodoSharedPreferences();
    initTodos();
  }

  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  void initTodos() async {
    _todos = await _todoSharedPreferences.getAllTodos();
    notifyListeners();
  }

  void saveTodo({
    String? id,
    required String title,
    required String description,
  }) async {
    Todo todo;
    if (id != null) {
      final selectedIndex = _todos.indexWhere((todo) => todo.id == id);
      final selectedTodo = _todos[selectedIndex];

      todo = selectedTodo.copyWith(
        title: title,
        description: description,
      );

      _todos[selectedIndex] = todo;
    } else {
      todo = Todo(
        title: title,
        description: description,
      );

      _todos.add(todo);
    }

    await _todoSharedPreferences.saveTodo(todo);
    notifyListeners();
  }

  void checkedTodo(String id) async {
    await _todoSharedPreferences.deleteTodoById(id);

    _todos.removeWhere((todo) => todo.id == id);

    notifyListeners();
  }
}
