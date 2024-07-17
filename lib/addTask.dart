import 'package:flutter/material.dart';

class AddTaskDialog extends StatefulWidget {
  final int currentWeek;
  final Function(String) onTaskAdded;

  AddTaskDialog({required this.currentWeek, required this.onTaskAdded});

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        'Add Task - Week ${widget.currentWeek}',
        style: TextStyle(color: Colors.lightBlue),
      ),
      content: TextField(
        controller: _taskController,
        cursorColor: Colors.lightBlue,
        cursorErrorColor: Colors.lightBlue,
        decoration: InputDecoration(
          iconColor: Colors.lightBlue,
          hoverColor: Colors.lightBlue,
          hintStyle: TextStyle(color: Colors.lightBlue),
          hintText: 'Enter task',
          fillColor: Colors.lightBlue,
          focusColor: Colors.lightBlue,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue),
          ),
        ),
      ),
      actions: [
        MaterialButton(
          padding: EdgeInsets.all(5),
          color: Colors.lightBlue,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        MaterialButton(
          padding: EdgeInsets.all(5),
          color: Colors.lightBlue,
          onPressed: () {
            final task = _taskController.text.trim();
            if (task.isNotEmpty) {
              widget.onTaskAdded(task);
              Navigator.of(context).pop();
            }
          },
          child: Text(
            'Add',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
