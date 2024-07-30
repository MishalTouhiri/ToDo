import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeekTasksView extends StatelessWidget {
  final List<String> tasks;
  final Function(String) onDelete;
  final Function(String) onComplete;
  final Function(String, String) onEdit;

  WeekTasksView({
    required this.onDelete,
    required this.onComplete,
    required this.onEdit,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskItem(
          task: tasks[index],
          onDelete: onDelete,
          onComplete: onComplete,
          onEdit: onEdit,
        );
      },
    );
  }
}

class TaskItem extends StatefulWidget {
  final String task;
  final Function(String) onDelete;
  final Function(String) onComplete;
  final Function(String, String) onEdit;

  TaskItem({
    required this.task,
    required this.onDelete,
    required this.onComplete,
    required this.onEdit,
  });

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.blue,
      iconColor: Colors.white,
      textColor: Colors.white,
      title: Text(widget.task),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _showEditDialog(context, widget.task);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              widget.onDelete(widget.task);
            },
          ),
          Checkbox(
            checkColor: Colors.white,
            hoverColor: Colors.white,
            activeColor: Colors.lightBlue,
            focusColor: Colors.white,
            value: _isChecked,
            onChanged: (bool? value) {
              setState(() {
                _isChecked = value!;
              });
              widget.onComplete(widget.task);
            },
          ),
        ],
      ),
      contentPadding: EdgeInsets.all(10),
    );
  }

  void _showEditDialog(BuildContext context, String currentTask) {
    TextEditingController _editController =
        TextEditingController(text: currentTask);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Edit Task',
          style: TextStyle(color: Colors.lightBlue),
        ),
        content: TextField(
          controller: _editController,
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
              Get.back();
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
              String editedTask = _editController.text.trim();
              if (editedTask.isNotEmpty) {
                widget.onEdit(currentTask, editedTask);
                Get.back();
              }
            },
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
