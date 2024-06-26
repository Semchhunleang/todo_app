import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../constrant/constrants.dart';
import '../../../constrant/image_asset.dart';
import '../../../utils/widgets/custom_appbar.dart';
import '../../../utils/widgets/custom_showmodal_bottomsheet.dart';
import '../../../utils/widgets/empty_state_widget.dart';
import '../data/model/category/category_model.dart';
import '../logic/todo_list_controller.dart';
import '../widgets/add_new_task_todo.dart';
import '../widgets/custom_card_task_todo.dart';
import '../widgets/delete_task.dart';
import '../widgets/show_more_widget.dart';

class TodoListPage extends StatelessWidget {
  final CategoryModel category;
  const TodoListPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final TodoListController controller = Get.find<TodoListController>();

    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: category.title,
        onPressed: () {
          Navigator.pop(context);
        },
        actions: [
          TextButton(
            onPressed: () {
              controller.isEdit = false;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddNewTaskTodo(
                    category: category,
                  );
                },
              );
            },
            child: Text(
              "Add",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
      body: GetBuilder<TodoListController>(
        builder: (controller) {
          final tasks = controller.todoCategoryList
              .firstWhere((cat) => cat.id == category.id)
              .taskList;
          return tasks.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(
                      top: padding, left: padding, right: padding),
                  child: SingleChildScrollView(
                    child: Column(
                        children: tasks.asMap().entries.map((e) {
                      return CustomCardTaskTodo(
                        label: e.value.taskLabel,
                        isComplete: e.value.isCompleted,
                        onTapComplete: () {
                          controller.onMarkComplete(category.title, e.key);
                          if (e.value.isCompleted) {
                            EasyLoading.showSuccess("Task is completed");
                          }
                        },
                        onTapMore: () {
                          onShowBottomSheet(
                            context: context,
                            height: MediaQuery.of(context).size.height * 0.23,
                            title: 'Done',
                            child: ShowMoreWidget(
                              onTapDelete: () {
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DeleteTask(
                                      index: e.key,
                                      titleCategory: category.title,
                                    );
                                  },
                                );
                              },
                              onTapEdit: () {
                                controller.isEdit = true;
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddNewTaskTodo(
                                      category: category,
                                      tasks: e.value,
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      );
                    }).toList()),
                  ),
                )
              : const EmptyStateWidget(
                  description: 'No task todo, please add your task',
                  imagePath: ImageAsset.emptyTask,
                );
        },
      ),
    );
  }
}
