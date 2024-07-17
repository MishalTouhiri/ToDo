import 'package:flutter/material.dart';
s
class WeekTasksView extends StatefulWidget {
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
  _WeekTasksViewState createState() => _WeekTasksViewState();
}

class _WeekTasksViewState extends State<WeekTasksView> {
  bool taskS = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {
        return ListTile(
          tileColor: Colors.blue,
          iconColor: Colors.white,
          textColor: Colors.white,
          title: Text(widget.tasks[index]),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _showEditDialog(context, widget.tasks[index]);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  widget.onDelete(widget.tasks[index]);
                },
              ),
              Checkbox(
                checkColor: Colors.white,
                hoverColor: Colors.white,
                activeColor: Colors.lightBlue,
                focusColor: Colors.white,
                value: taskS,
                onChanged: (bool? Value) {
                  setState(() {
                    taskS = Value ?? false;
                  });
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
                widget.onEdit(currentTask, editedTask);
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
