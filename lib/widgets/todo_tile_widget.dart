import 'package:flutter/material.dart';
import 'package:todoist_clone_app/constants.dart';
import 'package:todoist_clone_app/data/todo.dart';

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
              value: _isChecked,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _isChecked = value;
                  });
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
