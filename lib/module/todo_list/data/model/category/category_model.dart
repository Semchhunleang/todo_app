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
}
