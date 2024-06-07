import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constrant/app_color.dart';
import '../../../core/service_locator/service_locator.dart';
import '../../../utils/properties_widget.dart';
import '../data/model/category/category_model.dart';
import '../logic/todo_list_controller.dart';

class AddCategoryWidget extends StatelessWidget {
  const AddCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: getIt<TodoListController>().formKeyCategory,
      child: AlertDialog(
        title: const Text('Add Category List'),
        content: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColor.textColor,
                    ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: 'Enter category title',
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
                  getIt<TodoListController>().categoryTitle.value = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category title';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children:
                      getIt<TodoListController>().iconList.asMap().entries.map(
                    (e) {
                      return InkWell(
                        onTap: () {
                          getIt<TodoListController>().iconPath.value = e.value;

                          getIt<TodoListController>().selectedIconIndex.value =
                              e.key;
                          debugPrint(e.value);
                        },
                        child: Container(
                          width: 60.0,
                          height: 40.0,
                          padding: const EdgeInsets.all(5.0),
                          decoration: boxShadowDecoration(
                              backgroundColor: getIt<TodoListController>()
                                          .selectedIconIndex
                                          .value ==
                                      e.key
                                  ? AppColor.primaryColor
                                  : Colors.grey.shade300,
                              borderRadius: 20.0),
                          child: getIt<TodoListController>()
                                      .selectedIconIndex
                                      .value ==
                                  e.key
                              ? SvgPicture.asset(
                                  e.value,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                )
                              : SvgPicture.asset(e.value),
                        ),
                      );
                    },
                  ).toList()),
            ],
          ),
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
              debugPrint("below${getIt<TodoListController>().iconPath.value}");
              if (getIt<TodoListController>()
                  .formKeyCategory
                  .currentState!
                  .validate()) {
                if (getIt<TodoListController>()
                    .categoryTitle
                    .value
                    .isNotEmpty) {
                  getIt<TodoListController>().addCategory(CategoryModel(
                      id: DateTime.now().toString(),
                      icon: getIt<TodoListController>().iconPath.value,
                      title: getIt<TodoListController>().categoryTitle.value));
                  getIt<TodoListController>().onClearCategory();
                }
                // getIt<TodoListController>().todoCategoryList.add(CategoryModel(
                //     icon: getIt<TodoListController>().iconPath.value,
                //     title: getIt<TodoListController>().categoryTitle.value));
                // getIt<TodoListController>().onClearCategory();

                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
