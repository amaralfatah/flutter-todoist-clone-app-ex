import 'package:flutter/material.dart';
import 'package:todoist_clone_app/constants.dart';
import 'package:todoist_clone_app/data/todo.dart';
import 'package:todoist_clone_app/service/todo_shared_preferences.dart';
import 'package:todoist_clone_app/widgets/bottom_nav_bar_widget.dart';
import 'package:todoist_clone_app/widgets/todo_tile_widget.dart';

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({super.key});

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  late TodoSharedPreferences _todoSharedPreferences;
  List<Todo> _todos = [];

  String? _title;
  String? _description;

  @override
  void initState() {
    super.initState();

    _todoSharedPreferences = TodoSharedPreferences();
    _initTodos();
  }

  void _initTodos() async {
    var todos = await _todoSharedPreferences.getAllTodos();

    if (todos.isEmpty) {
      await _todoSharedPreferences
          .saveTodo(Todo(title: 'Task 1', description: 'Follow tiktok @programmerpangandaran'));
      await _todoSharedPreferences
          .saveTodo(Todo(title: 'Task 2', description: 'Follow instagram @amaralfatah.me'));
      await _todoSharedPreferences
          .saveTodo(Todo(title: 'Task 3', description: 'Follow github @amaralfatah'));

      todos = await _todoSharedPreferences.getAllTodos();
    }

    setState(() {
      _todos = todos;
    });
  }

  void addTodo() {
    if (_title != null && _description != null) {
      var todo = Todo(
        title: _title!,
        description: _description!,
      );

      _todoSharedPreferences.saveTodo(todo);

      setState(() {
        _todos.add(todo);
      });
    }
  }

  Future<void> _checkedTodo(String id) async {
    await _todoSharedPreferences.deleteTodoById(id);

    setState(() {
      _todos.removeWhere((todo) => todo.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.black,
      appBar: AppBar(
        backgroundColor: ColorPallete.black,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(
              Icons.more_horiz_outlined,
              color: ColorPallete.red,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Today',
              style: TextStyle(
                color: ColorPallete.white,
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '11 Aug - Sunday',
              style: TextStyle(
                color: ColorPallete.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(
            thickness: 0.1,
            color: ColorPallete.grey,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    TodoTileWidget(
                      key: ValueKey(_todos[index].id),
                      todo: _todos[index],
                      checkedTodo: _checkedTodo,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const Divider(
                      thickness: 0.1,
                      color: ColorPallete.grey,
                      indent: 40.0,
                    )
                  ],
                );
              },
              itemCount: _todos.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPallete.red,
        onPressed: () {
          _showAddTaskModalBottomSheet(context);
        },
        tooltip: 'Add Task',
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: ColorPallete.white,
        ),
      ),
      bottomNavigationBar: const BottomNavBarWidget(),
    );
  }

  void _showAddTaskModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorPallete.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 8.0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  _title = value;
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  hintText: 'Task Name',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: ColorPallete.grey,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
                style: const TextStyle(
                  color: ColorPallete.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  decorationThickness: 0,
                ),
                cursorColor: ColorPallete.red,
                autofocus: true,
              ),
              TextField(
                onChanged: (value) {
                  _description = value;
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  hintText: 'Description',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: ColorPallete.grey,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
                style: const TextStyle(
                  color: ColorPallete.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  decorationThickness: 0,
                ),
              ),
              const Divider(
                thickness: 0.1,
                color: ColorPallete.grey,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.inbox,
                      color: ColorPallete.white,
                    ),
                    IconButton(
                      onPressed: () {
                        addTodo();
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_circle_right,
                        color: ColorPallete.red,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
