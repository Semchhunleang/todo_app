import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_list_app/module/todo_list/data/model/tasks/tasks_model.dart';
import '../../../constrant/image_asset.dart';
import '../data/model/category/category_model.dart';

class TodoListController extends GetxController {
  @factoryMethod
  static init() => Get.put(TodoListController());
  final selectedIconIndex = 0.obs;
  final todoCategoryList = <CategoryModel>[].obs;
  final categoryTitle = "".obs;
  final taskLabel = "".obs;
  final iconPath = ImageAsset.task.obs;
  final GlobalKey<FormState> formKeyCategory = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyTask = GlobalKey<FormState>();
  final validationErrorCategory = false.obs;
  final isEdit = false.obs;
  final isDeleting = false.obs;
  final isExisting = false.obs;

  //*************** Add category todo ***********/
  void addCategory(CategoryModel category) {
    todoCategoryList.add(category);
  }

//*************** Add task todo ***********/
  void addTaskToCategory(String categoryName, TasksModel task) {
    final categoryIndex =
        todoCategoryList.indexWhere((cat) => cat.title == categoryName);
    if (categoryIndex != -1) {
      var updatedCategory = todoCategoryList[categoryIndex];
      // Check for duplicate task label
      if (updatedCategory.taskList.any((t) => t.taskLabel == task.taskLabel)) {
        isExisting(true);
        return; // Stop execution
      }
      updatedCategory.taskList = List.from(updatedCategory.taskList)
        ..add(task); // Create a new list and add the task
      todoCategoryList[categoryIndex] =
          updatedCategory; // Update the category in the observable list
      todoCategoryList.refresh(); // Refresh the list to update UI
    }
  }

  // *************** update task todo ***********/

  void updateTaskInCategory(String categoryName, TasksModel updatedTask) {
    final categoryIndex =
        todoCategoryList.indexWhere((cat) => cat.title == categoryName);
    if (categoryIndex != -1) {
      var category = todoCategoryList[categoryIndex];
      final taskIndex =
          category.taskList.indexWhere((task) => task.id == updatedTask.id);

      if (taskIndex != -1) {
        category.taskList[taskIndex] = updatedTask;
        todoCategoryList[categoryIndex] = category;
        todoCategoryList.refresh();
      }
    }
  }

  // *************** Delete task todo ***********/
  void deleteTaskFromCategory(String categoryName, int index) {
    final categoryIndex =
        todoCategoryList.indexWhere((cat) => cat.title == categoryName);
    if (categoryIndex != -1) {
      var category = todoCategoryList[categoryIndex];
      category.taskList.removeAt(index);
      todoCategoryList[categoryIndex] = category;
      todoCategoryList.refresh();
    }
  }

  // *************** Mark item as complete and incomplete ***********/
  onMarkComplete(String categoryName, int index) {
    final categoryIndex =
        todoCategoryList.indexWhere((cat) => cat.title == categoryName);
    if (categoryIndex != -1) {
      var updatedCategory = todoCategoryList[categoryIndex];
      updatedCategory.taskList[index].isCompleted =
          !updatedCategory.taskList[index].isCompleted;
      todoCategoryList[categoryIndex] = updatedCategory;
      todoCategoryList.refresh(); // Refresh the list to update UI
    }
  }

  //*************** change delete category ***********/
  void changeDeleting(bool value) {
    isDeleting.value = value;
  }

//*************** delete category ***********/
  void deleteCategory(CategoryModel category) {
    todoCategoryList.remove(category);
  }

  //*************** List of icon ***********/
  List<String> iconList = <String>[
    ImageAsset.task,
    ImageAsset.art,
    ImageAsset.cart,
    ImageAsset.bag,
    ImageAsset.headphones,
    ImageAsset.home,
    ImageAsset.plane,
    ImageAsset.book,
  ];

  //*************** Clear category data ***********/
  onClearCategory() {
    selectedIconIndex.value = 0;
    categoryTitle.value = "";
    iconPath.value = ImageAsset.task;
  }

  //*************** Clear category data ***********/
  onClearTask() {
    categoryTitle.value = "";
    isEdit(false);
    isExisting(false);
  }
}
