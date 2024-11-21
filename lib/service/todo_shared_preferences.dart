import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoist_clone_app/data/todo.dart';

class TodoSharedPreferences {
  static const todoListKey = 'todo_list_key';

  TodoSharedPreferences() {
    _init();
  }

  SharedPreferences? _sharedPreferences;

  Future<void> _init() async {
    if (_sharedPreferences != null) return;
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<List<Todo>> getAllTodos() async {
    await _init();

    if (_sharedPreferences == null) return [];

    final todoJson = _sharedPreferences!.getString(todoListKey);
    if (todoJson == null) return [];

    return _convertJsonToTodoLists(todoJson);
  }

  Future<void> saveTodo(Todo todo) async {
    await _init();

    final todoJson = _sharedPreferences!.getString(todoListKey);

    if (todoJson != null) {
      List<Todo> todos = _convertJsonToTodoLists(todoJson);

      final todoIndex = todos.indexWhere((element) => element.id == todo.id);

      if (todoIndex >= 0) {
        todos[todoIndex] = todo;
      } else {
        todos.add(todo);
      }

      if (_sharedPreferences != null) {
        await _sharedPreferences!.setString(todoListKey, jsonEncode(todos));
      }
    } else {
      List<Todo> todos = [todo];
      if (_sharedPreferences != null) {
        await _sharedPreferences!.setString(todoListKey, jsonEncode(todos));
      }
    }
  }

  Future<void> deleteTodoById(String id) async {
    await _init();
    final todoJson = _sharedPreferences!.getString(todoListKey);
    if (todoJson != null) {
      List<Todo> todos = _convertJsonToTodoLists(todoJson);
      final todoIndex = todos.indexWhere((t) => t.id == id);
      if (todoIndex == -1) {
        return;
      } else {
        todos.removeAt(todoIndex);
        if (_sharedPreferences != null) {
          await _sharedPreferences!.setString(todoListKey, jsonEncode(todos));
        }
      }
    }
  }

  List<Todo> _convertJsonToTodoLists(String todoJson) {
    return (json.decode(todoJson) as List<dynamic>)
        .map((todoJson) => Todo.fromJson(todoJson as Map<String, dynamic>))
        .toList();
  }
}
