import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasks_app_asignment/models/task_model.dart';
import 'package:tasks_app_asignment/task_database.dart';

import '../../models/task_model.dart';
import '../../models/task_model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final HiveDatabase hiveDatabase;

  TaskBloc({required this.hiveDatabase}) : super(TaskLoading()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
      on<DeleteAllTasks>(_onDeleteAllTask);
   
  }

  void _onLoadTasks(
    LoadTasks event,
    Emitter<TaskState> emit,
  ) async {
    Future<void>.delayed(const Duration(seconds: 1));
    Box box = await hiveDatabase.openBox();
    List<Task> tasks = hiveDatabase.getTasks(box);
    emit(TaskLoaded(tasks: tasks));
  }

  void _onUpdateTask(
    UpdateTask event,
    Emitter<TaskState> emit,
  ) async {
    Box box = await hiveDatabase.openBox();
    if (state is TaskLoaded) {
      await hiveDatabase.updateTask(box, event.task);
      emit(TaskLoaded(tasks: hiveDatabase.getTasks(box)));
    }
  }

  void _onAddTask(
    AddTask event,
    Emitter<TaskState> emit,
  ) async {
    Box box = await hiveDatabase.openBox();
    if (state is TaskLoaded) {
      hiveDatabase.addTask(box, event.task);
      emit(TaskLoaded(tasks: hiveDatabase.getTasks(box)));
    }
  }

  void _onDeleteTask(
    DeleteTask event,
    Emitter<TaskState> emit,
  ) async {
    Box box = await hiveDatabase.openBox();
    if (state is TaskLoaded) {
      hiveDatabase.deleteTask(box, event.task);
      emit(TaskLoaded(tasks: hiveDatabase.getTasks(box)));
    }
  }
  void _onDeleteAllTask(
    DeleteAllTasks event,
    Emitter<TaskState> emit,
  ) async {
    Box box = await hiveDatabase.openBox();
    if (state is TaskLoaded) {
      hiveDatabase.deleteAllTasks(box);
      emit(TaskLoaded(tasks: hiveDatabase.getTasks(box)));
    }
  }

}
