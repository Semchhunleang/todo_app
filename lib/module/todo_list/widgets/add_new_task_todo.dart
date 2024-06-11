import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/module/todo_list/data/model/category/category_model.dart';
import 'package:to_do_list_app/module/todo_list/data/model/tasks/tasks_model.dart';

import '../../../constrant/app_color.dart';
import '../logic/todo_list_controller.dart';

class AddNewTaskTodo extends StatelessWidget {
  final CategoryModel category;
  final TasksModel? tasks;
  const AddNewTaskTodo({super.key, required this.category, this.tasks});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoListController>(
      builder: (controller) {
        return Form(
          key: controller.formKeyTask,
          child: AlertDialog(
            title:
                Text(controller.isEdit ? 'Update task todo' : 'Add task todo'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColor.textColor,
                      ),
                  autofocus: true,
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
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorStyle: const TextStyle(color: Colors.red),
                  ),
                  onChanged: (value) {
                    controller.taskLabel = value;
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
                  controller.onClearTask();
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (controller.formKeyTask.currentState!.validate()) {
                    if (!controller.isEdit) {
                      final newTask = TasksModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        taskLabel: controller.taskLabel,
                      );
                      if (controller.taskLabel.isNotEmpty) {
                        controller.addTaskToCategory(category.title, newTask);
                        if (controller.isExisting) {
                          EasyLoading.showError("This task is existing");
                        } else {
                          EasyLoading.showSuccess("Add task Success");
                          Navigator.of(context).pop();
                        }
                        controller.onClearTask();
                      }
                    } else {
                      debugPrint("-----update ${controller.taskLabel}");
                      if (controller.taskLabel.isNotEmpty) {
                        final newTask = TasksModel(
                          id: tasks!.id,
                          taskLabel: controller.taskLabel,
                        );
                        controller.updateTaskInCategory(
                            category.title, newTask);
                        EasyLoading.showSuccess("Update task Success");
                        Navigator.of(context).pop();
                      }
                    }
                  }
                },
                child: Text(controller.isEdit ? 'Update' : 'Save'),
              ),
            ],
          ),
        );
      },
    );
  }
}
