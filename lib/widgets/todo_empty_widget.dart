import 'package:flutter/material.dart';

import '../constants.dart';

class TodoEmptyWidget extends StatelessWidget {
  const TodoEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
      ),
      width: double.infinity,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.edit_note,
            size: 100.0,
            color: ColorPallete.red,
          ),
          SizedBox(height: 20.0),
          Text(
            "You're all done with all the tasks",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: ColorPallete.grey
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            "Enjoy your day",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14.0,
              color: ColorPallete.grey,
            ),
          )
        ],
      ),
    );
  }
}