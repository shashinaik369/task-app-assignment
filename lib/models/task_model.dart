import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task extends Equatable with HiveObjectMixin {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final bool isDone;



  Task({
    required this.id,
    required this.title,
   
    required this.isDone,
  });

  Task copyWith({
    String? id,
    String? title,
   
    bool? isDone,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
     
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  List<Object?> get props => [id, title, isDone];
}