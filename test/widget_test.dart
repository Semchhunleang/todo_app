import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/constrant/image_asset.dart';
import 'package:to_do_list_app/core/service_locator/service_locator.dart';
import 'package:to_do_list_app/module/todo_list/data/model/category/category_model.dart';
import 'package:to_do_list_app/module/todo_list/data/model/tasks/tasks_model.dart';
import 'package:to_do_list_app/module/todo_list/logic/todo_list_controller.dart';
import 'package:to_do_list_app/module/todo_list/page/todo_list_page.dart';
import 'package:to_do_list_app/utils/widgets/empty_state_widget.dart';

void main() {
  setUpAll(() {
    // Initialize the service locator and other setups

    Get.put(TodoListController());
  });

  testWidgets('TodoListPage displays tasks and handles interactions',
      (WidgetTester tester) async {
    // Define a sample category with tasks
    final category = CategoryModel(
        id: '1',
        title: 'Work',
        icon: "assets/images/svg/plane.svg",
        taskList: [
          TasksModel(id: '1', taskLabel: 'Task 1', isCompleted: false),
          TasksModel(id: '2', taskLabel: 'Task 2', isCompleted: true),
        ]);

    // Assign the sample category to the controller
    final todoListController = Get.find<TodoListController>();
    todoListController.todoCategoryList.assignAll([category]);

    // Build the TodoListPage widget
    await tester.pumpWidget(
      GetMaterialApp(
        builder: EasyLoading.init(),
        home: TodoListPage(category: category),
      ),
    );

    // Verify that tasks are displayed correctly
    expect(find.text('Task 1'), findsOneWidget);
    expect(find.text('Task 2'), findsOneWidget);

    // Verify that the empty state widget is not displayed
    expect(find.byType(EmptyStateWidget), findsNothing);

    // Interact with the 'Add' button to add a new task
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    // Assume a new task is added through the dialog
    // Here, you need to implement the interaction logic for the dialog if it's present

    // Interact with a task to mark it as complete
    await tester.tap(find.text('Task 1'));
    await tester.pumpAndSettle();

    // Verify that the task is marked as complete
    expect(find.text('Task is completed'), findsOneWidget);

    // Interact with the 'More' button on a task (you need to add a button identifier)
    // await tester.tap(find.byKey(Key('more_button_1')));
    // await tester.pumpAndSettle();

    // Verify the bottom sheet or any other interactions
  });
}
