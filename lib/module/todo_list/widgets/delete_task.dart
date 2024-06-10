import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../core/service_locator/service_locator.dart';
import '../logic/todo_list_controller.dart';

class DeleteTask extends StatelessWidget {
  final int index;
  final String titleCategory;
  const DeleteTask(
      {super.key, required this.index, required this.titleCategory});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: getIt<TodoListController>().formKeyTask,
      child: AlertDialog(
        title: const Text('Confirmation'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Are you sure you want to delete this task?'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              getIt<TodoListController>()
                  .deleteTaskFromCategory(titleCategory, index);
              EasyLoading.showSuccess("Your task has been deleted");
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
