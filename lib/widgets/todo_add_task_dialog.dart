import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoist_clone_app/service/bloc/todo_bloc.dart';

import '../constants.dart';
import '../data/todo.dart';

class TodoAddTaskDialog extends StatefulWidget {
  final BuildContext mainContext;
  final Todo? todo;
  const TodoAddTaskDialog({
    required this.mainContext,
    this.todo,
    super.key,
  });

  @override
  State<TodoAddTaskDialog> createState() => _TodoAddTaskDialogState();
}

class _TodoAddTaskDialogState extends State<TodoAddTaskDialog> {
  String? _title;
  String? _description;

  @override
  void initState() {
    super.initState();

    if (widget.todo != null) {
      _title = widget.todo!.title;
      _description = widget.todo!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 8.0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: TextEditingController()..text = _title ?? "",
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
            controller: TextEditingController()..text = _description ?? "",
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
            cursorColor: ColorPallete.red,
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
                    if (_title != null && _description != null) {
                      if (widget.todo != null) {
                        widget.mainContext.read<TodoBloc>().add(
                              TodoEditEvent(
                                id: widget.todo!.id,
                                title: _title!,
                                description: _description!,
                              ),
                            );
                      } else {
                        widget.mainContext.read<TodoBloc>().add(
                              TodoAddEvent(
                                title: _title!,
                                description: _description!,
                              ),
                            );
                      }
                    }
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
  }

  bool get _isEditTask => widget.todo != null;
}
