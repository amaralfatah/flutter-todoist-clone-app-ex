import 'package:flutter/material.dart';
import 'package:todoist_clone_app/constants.dart';
import 'package:todoist_clone_app/data/todo.dart';

class TodoTileWidget extends StatefulWidget {
  final Todo todo;
  final Function(String) checkedTodo;
  const TodoTileWidget({
    required this.todo,
    required this.checkedTodo,
    super.key,
  });

  @override
  State<TodoTileWidget> createState() => _TodoTileWidgetState();
}

class _TodoTileWidgetState extends State<TodoTileWidget> {
  bool _isChecked = false;

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
                    widget.checkedTodo(widget.todo.id);
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
        Column(
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
        )
      ],
    );
  }
}
