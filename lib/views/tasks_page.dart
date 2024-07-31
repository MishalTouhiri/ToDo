import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todomonth/views/add_task_dialog.dart';
import '../controllers/tasks_controller.dart';
import 'week_tasks_view.dart';

class TasksPage extends StatelessWidget {
  TaskController taskController = Get.put(TaskController());

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
        ),
      ),
      body: Column(
        children: [
          GetBuilder<TaskController>(
            builder: (controller) {
              return TabBar(
                labelColor: Colors.lightBlue,
                indicatorColor: Colors.lightBlue,
                unselectedLabelColor: Colors.lightBlue,
                tabs: [
                  Tab(text: 'Week 1'),
                  Tab(text: 'Week 2'),
                  Tab(text: 'Week 3'),
                  Tab(text: 'Week 4'),
                ],
                controller: controller.tabController,
                onTap: (index) {
                  controller.updateWeek(index);
                },
              );
            },
          ),
          Expanded(
            child: GetBuilder<TaskController>(
              builder: (controller) {
                return TabBarView(
                  controller: controller.tabController,
                  children: [
                    WeekTasksView(
                      tasks: controller.tasks[0],
                      onDelete: (task) => controller.deleteTask(0, task),
                      onComplete: (task) => controller.completeTask(0, task),
                      onEdit: (oldTask, newTask) =>
                          controller.editTask(0, oldTask, newTask),
                    ),
                    WeekTasksView(
                      tasks: controller.tasks[1],
                      onDelete: (task) => controller.deleteTask(1, task),
                      onComplete: (task) => controller.completeTask(1, task),
                      onEdit: (oldTask, newTask) =>
                          controller.editTask(1, oldTask, newTask),
                    ),
                    WeekTasksView(
                      tasks: controller.tasks[2],
                      onDelete: (task) => controller.deleteTask(2, task),
                      onComplete: (task) => controller.completeTask(2, task),
                      onEdit: (oldTask, newTask) =>
                          controller.editTask(2, oldTask, newTask),
                    ),
                    WeekTasksView(
                      tasks: controller.tasks[3],
                      onDelete: (task) => controller.deleteTask(3, task),
                      onComplete: (task) => controller.completeTask(3, task),
                      onEdit: (oldTask, newTask) =>
                          controller.editTask(3, oldTask, newTask),
                    ),
                  ],
                );
              },
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
              currentWeek: taskController.currentWeek + 1,
              onTaskAdded: (task) {
                taskController.addTask(taskController.currentWeek, task);
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
