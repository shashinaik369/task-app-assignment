
import 'package:hive_flutter/hive_flutter.dart';

import 'models/task_model.dart';

class HiveDatabase {
  String boxName = 'Completed_Tasks';
  Type boxType = Task;

  Future<Box> openBox() async {
    Box box = await Hive.openBox<Task>(boxName);
    return box;
  }

  List<Task> getTasks(Box box) {
    return box.values.toList() as List<Task>;
  }

  Future<void> addTask(Box box, Task task) async {
    await box.put(task.id, task);
  }

  Future<void> updateTask(Box box, Task task) async {
    await box.put(task.id, task);
  }

  Future<void> deleteTask(Box box, Task task) async {
    await box.delete(task.id);
  }

  Future<void> deleteAllTasks(Box box) async {
    await box.clear();
  }
}
