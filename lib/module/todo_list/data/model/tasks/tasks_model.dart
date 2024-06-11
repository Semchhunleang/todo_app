class TasksModel {
  final String id;
  final String taskLabel;
  bool isCompleted;

  TasksModel(
      {required this.id, required this.taskLabel, this.isCompleted = false});

  // Convert a TasksModel into a Map.
  Map<String, dynamic> toJson() => {
        'id': id,
        'taskLabel': taskLabel,
        'isCompleted': isCompleted,
      };

  // Create a TasksModel from a Map.
  factory TasksModel.fromJson(Map<String, dynamic> json) {
    return TasksModel(
      id: json['id'],
      taskLabel: json['taskLabel'],
      isCompleted: json['isCompleted'],
    );
  }
}
