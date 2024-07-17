import 'package:flutter/material.dart';

class WeekTasksView extends StatelessWidget {
  final List<String> tasks;
  final Function(String) onDelete;
  final Function(String) onComplete;
  final Function(String, String) onEdit;

  WeekTasksView({
    required this.tasks,
    required this.onDelete,
    required this.onComplete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return ListTile(
          tileColor: Colors.blue,
          iconColor: Colors.white,
          textColor: Colors.white,
          title: Text(tasks[index]),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit_calendar),
                onPressed: () {
                  _showEditDialog(context, tasks[index]);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  onComplete(tasks[index]);
                },
              ),
            ],
          ),
          contentPadding: EdgeInsets.all(10),
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, String currentTask) {
    TextEditingController _editController =
        TextEditingController(text: currentTask);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Task'),
        content: TextField(
          controller: _editController,
          cursorColor: Colors.lightBlue,
          cursorErrorColor: Colors.lightBlue,
          style: TextStyle(
              color: Colors.lightBlue,
              decorationColor: Colors.lightBlue,
              backgroundColor: Colors.lightBlue),
          decoration: InputDecoration(
            iconColor: Colors.lightBlue,
            hoverColor: Colors.lightBlue,
            hintStyle: TextStyle(color: Colors.lightBlue),
            hintText: 'Enter task',
            fillColor: Colors.lightBlue,
            focusColor: Colors.lightBlue,
            suffixIconColor: Colors.lightBlue,
            prefixIconColor: Colors.lightBlue,
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
              String editedTask = _editController.text.trim();
              if (editedTask.isNotEmpty) {
                onEdit(currentTask, editedTask);

                Navigator.of(context).pop();
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
