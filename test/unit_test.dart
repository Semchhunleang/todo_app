// test/todo_controller_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/module/todo_list/data/model/category/category_model.dart';
import 'package:to_do_list_app/module/todo_list/data/model/tasks/tasks_model.dart';
import 'package:to_do_list_app/module/todo_list/logic/todo_list_controller.dart';

void main() {
  group('TodoController', () {
    late TodoListController todoListController;

    setUp(() {
      todoListController = TodoListController();
      Get.put(todoListController);
    });

    tearDown(() {
      Get.reset();
    });

    test('should add a category', () {
      final category = CategoryModel(id: '1', icon: 'icon1', title: 'Work');
      todoListController.addCategory(category);

      expect(todoListController.todoCategoryList.length, 1);
      expect(todoListController.todoCategoryList.first.id, '1');
      expect(todoListController.todoCategoryList.first.icon, 'icon1');
      expect(todoListController.todoCategoryList.first.title, 'Work');
    });

    test('should add a todo task to a category', () {
      final category = CategoryModel(id: '1', icon: 'icon1', title: 'Work');
      todoListController.addCategory(category);

      final task = TasksModel(id: 'task1', taskLabel: 'Finish report');
      todoListController.addTaskToCategory('Work', task);

      expect(todoListController.todoCategoryList.first.taskList.length, 1);
      expect(
          todoListController.todoCategoryList.first.taskList.first.id, 'task1');
      expect(todoListController.todoCategoryList.first.taskList.first.taskLabel,
          'Finish report');
      expect(
          todoListController.todoCategoryList.first.taskList.first.isCompleted,
          false);
    });

    test('should not add duplicate tasks to a category', () {
      final category = CategoryModel(id: '1', icon: 'icon1', title: 'Work');
      todoListController.addCategory(category);

      final task1 = TasksModel(id: 'task1', taskLabel: 'Finish report');
      final task2 = TasksModel(
          id: 'task2', taskLabel: 'Finish report'); // Duplicate taskLabel

      todoListController.addTaskToCategory('Work', task1);
      todoListController.addTaskToCategory('Work', task2);

      expect(todoListController.todoCategoryList.first.taskList.length,
          1); // Should still be 1
      expect(todoListController.isExisting, true); // Duplicate task detected
    });
  });
}
