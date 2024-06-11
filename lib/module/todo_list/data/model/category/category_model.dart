import '../tasks/tasks_model.dart';

class CategoryModel {
  final String id;
  final String icon;
  final String title;
  List<TasksModel> taskList;

  CategoryModel(
      {required this.id,
      required this.icon,
      required this.title,
      this.taskList = const []});
// Convert a CategoryModel into a Map.
  Map<String, dynamic> toJson() => {
        'id': id,
        'icon': icon,
        'title': title,
        'taskList': taskList.map((task) => task.toJson()).toList(),
      };

  // Create a CategoryModel from a Map.
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      icon: json['icon'],
      title: json['title'],
      taskList: (json['taskList'] as List)
          .map((taskJson) => TasksModel.fromJson(taskJson))
          .toList(),
    );
  }
}
