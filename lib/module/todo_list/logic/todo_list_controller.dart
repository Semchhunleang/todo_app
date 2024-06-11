import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:to_do_list_app/module/todo_list/data/model/category/category_model.dart';
import 'package:to_do_list_app/module/todo_list/data/model/tasks/tasks_model.dart';
import '../../../constrant/image_asset.dart';

class TodoListController extends GetxController {
  final storage = GetStorage();

  int selectedIconIndex = 0;
  List<CategoryModel> todoCategoryList = [];
  String categoryTitle = "";
  String taskLabel = "";
  String iconPath = ImageAsset.task;
  final GlobalKey<FormState> formKeyCategory = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyTask = GlobalKey<FormState>();
  bool validationErrorCategory = false;
  bool isEdit = false;
  bool isDeleting = false;
  bool isExisting = false;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  //*************** Add category todo ***********/
  void addCategory(CategoryModel category) {
    todoCategoryList.add(category);
    saveCategories();
    update();
  }

  //*************** Add task todo ***********/
  void addTaskToCategory(String categoryName, TasksModel task) {
    final categoryIndex =
        todoCategoryList.indexWhere((cat) => cat.title == categoryName);
    if (categoryIndex != -1) {
      var updatedCategory = todoCategoryList[categoryIndex];
      // Check for duplicate task label
      if (updatedCategory.taskList.any((t) => t.taskLabel == task.taskLabel)) {
        isExisting = true;
        update();
        return; // Stop execution
      }
      updatedCategory.taskList = List.from(updatedCategory.taskList)
        ..add(task); // Create a new list and add the task
      todoCategoryList[categoryIndex] =
          updatedCategory; // Update the category in the list
      saveCategories();
      update(); // Refresh the list to update UI
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
        saveCategories();
        update();
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
      saveCategories();
      update();
    }
  }

  // *************** Mark item as complete and incomplete ***********/
  void onMarkComplete(String categoryName, int index) {
    final categoryIndex =
        todoCategoryList.indexWhere((cat) => cat.title == categoryName);
    if (categoryIndex != -1) {
      var updatedCategory = todoCategoryList[categoryIndex];
      updatedCategory.taskList[index].isCompleted =
          !updatedCategory.taskList[index].isCompleted;
      todoCategoryList[categoryIndex] = updatedCategory;
      saveCategories();
      update(); // Refresh the list to update UI
    }
  }

  //*************** change delete category ***********/
  void changeDeleting(bool value) {
    isDeleting = value;
    update();
  }

  //*************** delete category ***********/
  void deleteCategory(CategoryModel category) {
    todoCategoryList.remove(category);
    saveCategories();
    update();
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
  void onClearCategory() {
    selectedIconIndex = 0;
    categoryTitle = "";
    iconPath = ImageAsset.task;
    update();
  }

  //*************** Clear task data ***********/
  void onClearTask() {
    categoryTitle = "";
    isEdit = false;
    isExisting = false;
    update();
  }

  //*************** Save categories to local storage ***********/
  Future<void> saveCategories() async {
    try {
      final storage = GetStorage();
      final jsonData = storage.read<List<dynamic>>(
          'todoCategoryList'); // Specify the data type explicitly
      if (jsonData != null) {
        todoCategoryList = jsonData
            .map((categoryJson) => CategoryModel.fromJson(categoryJson))
            .toList();
        update();
      }
    } catch (e) {
      print('Error loading categories: $e');
    }
    // final encodedData =
    //     todoCategoryList.map((category) => category.toJson()).toList();
    // await storage.write('todoCategoryList', jsonEncode(encodedData));
  }

  //*************** Load categories from local storage ***********/
  Future<void> loadCategories() async {
    final storedData = storage.read('todoCategoryList');
    if (storedData != null) {
      final List<dynamic> decodedData = jsonDecode(storedData);
      todoCategoryList =
          decodedData.map((json) => CategoryModel.fromJson(json)).toList();
      update();
    }
  }
}
