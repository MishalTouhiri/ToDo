import 'package:flutter/material.dart';
import 'package:todomonth/WeekTasks.dart';
import 'package:todomonth/addTask.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weekly Tasks App',
      debugShowCheckedModeBanner: false,
      home: TasksPage(),
    );
  }
}

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentWeek = 0;

  List<List<String>> _tasks = [
    [],
    [],
    [],
    [],
  ];

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          actionsIconTheme: IconThemeData(),
          centerTitle: true,
          title: Row(
            children: [
              Icon(
                Icons.edit_calendar,
                color: Colors.white,
              ),
              Text(
                'TodOMonth',
                style: TextStyle(color: Colors.white),
              ),
            ],
          )),
      body: Column(
        children: [
          TabBar(
            labelColor: Colors.lightBlue,
            dividerColor: Colors.lightBlue,
            indicatorColor: Colors.lightBlue,
            unselectedLabelColor: Colors.lightBlue,
            tabs: [
              Tab(text: 'Week 1'),
              Tab(text: 'Week 2'),
              Tab(text: 'Week 3'),
              Tab(text: 'Week 4'),
            ],
            controller: _tabController,
            onTap: (index) {
              setState(() {
                _currentWeek = index;
              });
            },
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                WeekTasksView(
                  tasks: _tasks[0],
                  onDelete: (String) {},
                  onComplete: (String) {},
                  onEdit: (String, l) {},
                ),
                WeekTasksView(
                  tasks: _tasks[1],
                  onDelete: (String) {},
                  onComplete: (String) {},
                  onEdit: (String, l) {},
                ),
                WeekTasksView(
                  tasks: _tasks[2],
                  onDelete: (String) {},
                  onComplete: (String) {},
                  onEdit: (String, l) {},
                ),
                WeekTasksView(
                  tasks: _tasks[3],
                  onDelete: (String) {},
                  onComplete: (String) {},
                  onEdit: (String, l) {},
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddTaskDialog(
              currentWeek: _currentWeek + 1,
              onTaskAdded: (task) {
                setState(() {
                  _tasks[_currentWeek].add(task as String);
                });
              },
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
