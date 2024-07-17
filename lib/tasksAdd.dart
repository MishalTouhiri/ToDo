// // import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:todomonth/WeekTasks.dart';
// import 'package:todomonth/addTask.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Weekly Tasks App',
//       home: TasksPage(),
//     );
//   }
// }

// class TasksPage extends StatefulWidget {
//   @override
//   _TasksPageState createState() => _TasksPageState();
// }

// class _TasksPageState extends State<TasksPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int _currentWeek = 0;

//   List<List<String>> _tasks = [
//     [],
//     [],
//     [],
//     [],
//   ];

//   @override
//   void initState() {
//     _tabController = TabController(length: 4, vsync: this);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actionsIconTheme: IconThemeData(),
//         centerTitle: true,
//         title: Text('TodOMonth'),
//       ),
//       body: Column(
//         children: [
//           TabBar(
//             tabs: [
//               Tab(text: 'Week 1'),
//               Tab(text: 'Week 2'),
//               Tab(text: 'Week 3'),
//               Tab(text: 'Week 4'),
//             ],
//             controller: _tabController,
//             onTap: (index) {
//               setState(() {
//                 _currentWeek = index;
//               });
//             },
//           ),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 WeekTasksView(
//                   tasks: _tasks[0],
//                   onEdit: (oldTask, newTask) => _editTask(0, oldTask, newTask),
//                   onDelete: (task) => _deleteTask(0, task),
//                   onComplete: (task) => _completeTask(0, task),
//                 ),
//                 WeekTasksView(
//                   tasks: _tasks[1],
//                   onEdit: (oldTask, newTask) => _editTask(1, oldTask, newTask),
//                   onDelete: (task) => _deleteTask(1, task),
//                   onComplete: (task) => _completeTask(1, task),
//                 ),
//                 WeekTasksView(
//                   tasks: _tasks[2],
//                   onEdit: (oldTask, newTask) => _editTask(2, oldTask, newTask),
//                   onDelete: (task) => _deleteTask(2, task),
//                   onComplete: (task) => _completeTask(2, task),
//                 ),
//                 WeekTasksView(
//                   tasks: _tasks[3],
//                   onEdit: (oldTask, newTask) => _editTask(3, oldTask, newTask),
//                   onDelete: (task) => _deleteTask(3, task),
//                   onComplete: (task) => _completeTask(3, task),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) => AddTaskDialog(
//               currentWeek: _currentWeek + 1,
//               onTaskAdded: (task, isCompleted) {
//                 setState(() {
//                   _tasks[_currentWeek].add(task);
//                   if (isCompleted) {
//                     _completeTask(_currentWeek, task);
//                   }
//                 });
//               },
//             ),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   void _editTask(int weekIndex, String oldTask, String newTask) {
//     setState(() {
//       int index = _tasks[weekIndex].indexOf(oldTask);
//       if (index != -1) {
//         _tasks[weekIndex][index] = newTask;
//       }
//     });
//   }

//   void _deleteTask(int weekIndex, String task) {
//     setState(() {
//       _tasks[weekIndex].remove(task);
//     });
//   }

//   void _completeTask(int weekIndex, String task) {
//     // Implement logic to mark task as completed
//     print('Task completed: $task');
//   }
// }

// class AddTaskDialog extends StatefulWidget {
//   final int currentWeek;
//   final Function(String, bool) onTaskAdded;

//   AddTaskDialog({required this.currentWeek, required this.onTaskAdded});

//   @override
//   _AddTaskDialogState createState() => _AddTaskDialogState();
// }

// class _AddTaskDialogState extends State<AddTaskDialog> {
//   late TextEditingController _taskController;
//   bool _isCompleted = false;

//   @override
//   void initState() {
//     super.initState();
//     _taskController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _taskController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Add New Task'),
//       content: Container(
//         width: double.maxFinite,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: _taskController,
//               decoration: InputDecoration(
//                 hintText: 'Enter task name',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_taskController.text.isNotEmpty) {
//                       widget.onTaskAdded(_taskController.text, _isCompleted);
//                       Navigator.of(context).pop();
//                     }
//                   },
//                   child: Text('Add'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       _isCompleted = !_isCompleted;
//                     });
//                   },
//                   child: Text(_isCompleted ? 'Undo Complete' : 'Complete'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('Cancel'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class WeekTasksView extends StatelessWidget {
//   final List<String> tasks;
//   final Function(String, String) onEdit;
//   final Function(String) onDelete;
//   final Function(String) onComplete;

//   WeekTasksView({
//     required this.tasks,
//     required this.onEdit,
//     required this.onDelete,
//     required this.onComplete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(tasks[index]),
//           trailing: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.edit),
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       title: Text('Edit Task'),
//                       content: Text('Edit Task: ${tasks[index]}'),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: Text('Cancel'),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             // Implement edit action
//                             Navigator.of(context).pop();
//                             onEdit(tasks[index], 'New Task Name'); // Replace 'New Task Name' with updated task
//                           },
//                           child: Text('Save'),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               IconButton(
//                 icon: Icon(Icons.delete),
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       title: Text('Delete Task'),
//                       content: Text('Are you sure you want to delete the task: ${tasks[index]}?'),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: Text('Cancel'),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                             onDelete(tasks[index]);
//                           },
//                           child: Text('Delete'),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               IconButton(
//                 icon: Icon(Icons.check_circle),
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       title: Text('Complete Task'),
//                       content: Text('Mark task as completed: ${tasks[index]}?'),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: Text('Cancel'),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                             onComplete(tasks[index]);
//                           },
//                           child: Text('Complete'),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
