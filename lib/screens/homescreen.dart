import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasks_app_asignment/blocs/task/task_bloc.dart';
import 'package:tasks_app_asignment/models/task_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Your Tasks'),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<TaskBloc>(context).add(DeleteAllTasks());
            },
            icon: const Icon(Icons.clear),
          )
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TaskLoaded) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                Task task = state.tasks[index];
                return ListTile(
                  contentPadding: const EdgeInsets.all(10),
       
                  title: Text(task.title,style:  TextStyle(decoration: task.isDone ? TextDecoration.lineThrough : null),),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.check_box,
                          color: task.isDone
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        ),
                        onPressed: () {
                          context.read<TaskBloc>().add(
                                UpdateTask(
                                  task: task.copyWith(
                                    isDone: !task.isDone,
                                  ),
                                ),
                              );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showModalBottomSheet(context: context, task: task);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<TaskBloc>().add(
                                DeleteTask(task: task),
                              );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Text('Something went wrong.');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showModalBottomSheet(context: context),
      ),
    );
  }

  void _showModalBottomSheet({
    required BuildContext context,
    Task? task,
  }) async {
    Random random = Random();
    TextEditingController titleController = TextEditingController();

    if (task != null) {
      titleController.text = task.title;
    }

    showModalBottomSheet(
      isDismissible: true,
      elevation: 5,
      context: context,
      builder: (context) => Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(labelText: 'task'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (task != null) {
                    context.read<TaskBloc>().add(
                          UpdateTask(
                            task: task.copyWith(
                              title: titleController.text,
                            ),
                          ),
                        );
                  } else {
                    Task task = Task(
                      id: '${random.nextInt(10000)}',
                      title: titleController.text,
                      isDone: false,
                    );

                    context.read<TaskBloc>().add(AddTask(task: task));
                  }
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
