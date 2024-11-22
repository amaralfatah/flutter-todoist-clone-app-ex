import 'package:flutter/material.dart';
import 'package:todoist_clone_app/widgets/todo_add_task_dialog.dart';

import 'constants.dart';
import 'data/todo.dart';

extension DialogExtension on BuildContext {
  void showAddTaskModalDialog({
    Todo? todo,
  }) {
    showModalBottomSheet(
      context: this,
      backgroundColor: ColorPallete.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      isScrollControlled: true,
      builder: (_) => TodoAddTaskDialog(mainContext: this, todo: todo),
    );
  }
}
