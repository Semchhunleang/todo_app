class TasksModel {
  final String id;
  final String taskLabel;
  bool isCompleted;

  TasksModel(
      {required this.id, required this.taskLabel, this.isCompleted = false});
}
