import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskController extends GetxController with SingleGetTickerProviderMixin {
  late TabController tabController;
  int currentWeek = 0;
  
  List<List<String>> tasks = [
    [],
    [],
    [],
    [],
  ];

  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void updateWeek(int index) {
    currentWeek = index;
    update();
  }

  void addTask(int week, String task) {
    tasks[week].add(task);
    update();
  }

  void deleteTask(int week, String task) {
    tasks[week].remove(task);
    update();
  }

  void completeTask(int week, String task) {

  }

  void editTask(int week, String oldTask, String newTask) {
    int taskIndex = tasks[week].indexOf(oldTask);
    if (taskIndex != -1) {
      tasks[week][taskIndex] = newTask;
    }
    update();
  }
  
}
