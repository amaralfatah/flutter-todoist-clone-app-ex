import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoist_clone_app/service/bloc/todo_bloc.dart';
import 'package:todoist_clone_app/service/todo_shared_preferences.dart';
import 'package:todoist_clone_app/todo_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider<TodoBloc>(
        create: (_) => TodoBloc(TodoSharedPreferences())..add(TodoInitEvent()),
        child: const TodoHomeScreen(),
      ),
    );
  }
}
