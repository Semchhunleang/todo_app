import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_do_list_app/main.dart';
import 'package:to_do_list_app/module/todo_list/widgets/add_category_widget.dart';
import 'package:to_do_list_app/module/todo_list/widgets/add_new_task_todo.dart';
import 'package:to_do_list_app/module/todo_list/widgets/custom_button_add_category.dart';
import 'package:to_do_list_app/module/todo_list/widgets/custom_card_category.dart';
import 'package:to_do_list_app/utils/widgets/empty_state_widget.dart';

void main() {
  setUpAll(() async {
    // Initialize GetStorage before running tests
    await GetStorage.init();
  });

  setUp(() async {
    // Clear storage before each test to ensure a clean state
    final storage = GetStorage();
    await storage.erase();
  });

  testWidgets('Test adding a new category', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify that initially there are no categories
    expect(find.byType(CustomButtonAddCategory), findsOneWidget);

    // Tap on the add category button
    await tester.tap(find.byType(CustomButtonAddCategory));
    await tester.pumpAndSettle();

    // Enter category title and save
    expect(find.byType(AddCategoryWidget), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), 'Work');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Verify that the category is added
    expect(find.byType(CustomCardCategory), findsOneWidget);
    expect(find.text('Work'), findsOneWidget);
  });

  testWidgets('Test adding a new task', (WidgetTester tester) async {
    // Pump the widget tree
    await tester.pumpWidget(const MyApp());

    // Tap on the add category button
    await tester.tap(find.byType(CustomButtonAddCategory));
    await tester.pumpAndSettle();

    // Enter category title and save
    await tester.enterText(find.byType(TextFormField), 'Cart');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Tap on the category to add a new task
    await tester.tap(find.text('Cart'));
    await tester.pumpAndSettle();

    // Verify that initially there are no tasks
    expect(find.byType(EmptyStateWidget), findsOneWidget);

    // Tap on add task button
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    // Enter task label and save
    expect(find.byType(AddNewTaskTodo), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), 'Finish report');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Verify that the task is added
    expect(find.text('Finish report'), findsOneWidget);
  });
}
