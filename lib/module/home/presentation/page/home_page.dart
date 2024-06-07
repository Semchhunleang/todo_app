import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/constrant/constrants.dart';
import 'package:to_do_list_app/module/todo_list/data/model/category/category_model.dart';

import '../../../../core/service_locator/service_locator.dart';
import '../../../todo_list/logic/todo_list_controller.dart';
import '../../../todo_list/page/todo_list_page.dart';
import '../../../todo_list/widgets/custom_button_add_category.dart';
import '../../../todo_list/widgets/custom_card_category.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Lists",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: padding,
              ),
              Obx(
                () => getIt<TodoListController>().todoCategoryList.isNotEmpty
                    ? Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15.0,
                          mainAxisSpacing: 15.0,
                          childAspectRatio: 1.3,
                          children: [
                            const CustomButtonAddCategory(),
                            ...getIt<TodoListController>()
                                .todoCategoryList
                                .asMap()
                                .entries
                                .map((e) {
                              return LongPressDraggable(
                                data: e.value,
                                onDragStarted: () => getIt<TodoListController>()
                                    .changeDeleting(true),
                                onDraggableCanceled: (_, __) =>
                                    getIt<TodoListController>()
                                        .changeDeleting(false),
                                onDragEnd: (_) => getIt<TodoListController>()
                                    .changeDeleting(false),
                                feedback: Opacity(
                                  opacity: 0.8,
                                  child: CustomCardCategory(
                                    categoryModel: e.value,
                                    countItem: e.value.taskList.length,
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TodoListPage(
                                                category: e.value,
                                              )),
                                    );
                                  },
                                  child: CustomCardCategory(
                                    categoryModel: e.value,
                                    countItem: e.value.taskList.length,
                                  ),
                                ),
                              );
                            })
                          ],
                        ),
                      )
                    : const CustomButtonAddCategory(),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Obx(() {
          return getIt<TodoListController>().deleting.value
              ? SizedBox(
                  width: 56.0,
                  height: 56.0,
                  child: DragTarget<CategoryModel>(
                    builder: (_, __, ___) {
                      return FloatingActionButton(
                        backgroundColor: Colors.red,
                        onPressed: () {},
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      );
                    },
                    onAcceptWithDetails: (task) {
                      getIt<TodoListController>().deleteCategory(task.data);
                      EasyLoading.showSuccess("Delete Success");
                    },
                  ),
                )
              : Container();
        }));
  }
}
