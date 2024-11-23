import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoist_clone_app/constants.dart';
import 'package:todoist_clone_app/data/todo.dart';
import 'package:todoist_clone_app/extension.dart';
import 'package:todoist_clone_app/service/bloc/todo_bloc.dart';

class TodoTileWidget extends StatefulWidget {
  final Todo todo;

  const TodoTileWidget({
    required this.todo,
    super.key,
  });

  @override
  State<TodoTileWidget> createState() => _TodoTileWidgetState();
}

class _TodoTileWidgetState extends State<TodoTileWidget> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();

    _isChecked = widget.todo.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: Transform.scale(
            scale: 1.2,
            child: Checkbox(
              activeColor: ColorPallete.red,
              value: _isChecked,
              onChanged: (value) async {
                if (value != null) {
                  setState(() {
                    _isChecked = value;
                  });

                  if (value == true) {
                    await Future.delayed(const Duration(milliseconds: 800));
                    if (mounted) {
                      context
                          .read<TodoBloc>()
                          .add(TodoDeleteEvent(id: widget.todo.id));
                    }
                  }
                }
              },
              shape: const CircleBorder(),
              side: const BorderSide(
                width: 0.5,
                color: ColorPallete.grey,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 12.0,
        ),
        GestureDetector(
          onTap: () {
            context.showAddTaskModalDialog(todo: widget.todo);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.todo.title,
                style: const TextStyle(
                  color: ColorPallete.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                widget.todo.description,
                style: const TextStyle(
                  color: ColorPallete.grey,
                  fontSize: 12.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
