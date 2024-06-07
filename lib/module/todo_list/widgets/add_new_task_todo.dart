import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:to_do_list_app/module/todo_list/data/model/category/category_model.dart';
import 'package:to_do_list_app/module/todo_list/data/model/tasks/tasks_model.dart';

import '../../../constrant/app_color.dart';
import '../../../core/service_locator/service_locator.dart';
import '../logic/todo_list_controller.dart';

class AddNewTaskTodo extends StatelessWidget {
  final CategoryModel category;
  final TasksModel? tasks;
  const AddNewTaskTodo({super.key, required this.category, this.tasks});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: getIt<TodoListController>().formKeyTask,
      child: AlertDialog(
        title: Text(getIt<TodoListController>().isEdit.value
            ? 'Update task todo'
            : 'Add task todo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColor.textColor,
                  ),
              initialValue: tasks != null ? tasks!.taskLabel : "",
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: 'Enter task todo',
                hintStyle: Theme.of(context).textTheme.bodyLarge,
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: const UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.red), // Change color here
                ),
                errorStyle: const TextStyle(color: Colors.red),
              ),
              onChanged: (value) {
                getIt<TodoListController>().taskLabel.value = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a todo task';
                }
                return null;
              },
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              getIt<TodoListController>().onClearTask();
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (getIt<TodoListController>()
                  .formKeyTask
                  .currentState!
                  .validate()) {
                if (!getIt<TodoListController>().isEdit.value) {
                  debugPrint(
                      "-----add ${getIt<TodoListController>().taskLabel.value}");
                  final newTask = TasksModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    taskLabel: getIt<TodoListController>().taskLabel.value,
                  );
                  if (getIt<TodoListController>().taskLabel.value.isNotEmpty) {
                    getIt<TodoListController>()
                        .addTaskToCategory(category.title, newTask);
                    EasyLoading.showSuccess("Add task Success");
                    getIt<TodoListController>().onClearTask();
                  }
                } else {
                  debugPrint(
                      "-----update ${getIt<TodoListController>().taskLabel.value}");
                  if (getIt<TodoListController>().taskLabel.value.isNotEmpty) {
                    final newTask = TasksModel(
                      id: tasks!.id,
                      taskLabel: getIt<TodoListController>().taskLabel.value,
                    );
                    getIt<TodoListController>()
                        .updateTaskInCategory(category.title, newTask);
                    EasyLoading.showSuccess("Update task Success");
                  }
                }

                Navigator.of(context).pop();
              }
            },
            child: Text(
                getIt<TodoListController>().isEdit.value ? 'Update' : 'Save'),
          ),
        ],
      ),
    );
  }
}
