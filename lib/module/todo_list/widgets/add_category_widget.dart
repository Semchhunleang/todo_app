import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../constrant/app_color.dart';
import '../../../utils/properties_widget.dart';
import '../data/model/category/category_model.dart';
import '../logic/todo_list_controller.dart';

class AddCategoryWidget extends StatelessWidget {
  const AddCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoListController>(
      builder: (controller) {
        return Form(
          key: controller.formKeyCategory,
          child: AlertDialog(
            title: const Text('Add Category List'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColor.textColor,
                      ),
                  autofocus: true,
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
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorStyle: const TextStyle(color: Colors.red),
                  ),
                  onChanged: (value) {
                    controller.categoryTitle = value;
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
                    children: controller.iconList.asMap().entries.map(
                      (e) {
                        return InkWell(
                          onTap: () {
                            controller.iconPath = e.value;
                            controller.selectedIconIndex = e.key;
                            controller.update(); // Update UI
                            debugPrint(e.value);
                          },
                          child: Container(
                            width: 60.0,
                            height: 40.0,
                            padding: const EdgeInsets.all(5.0),
                            decoration: boxShadowDecoration(
                                backgroundColor:
                                    controller.selectedIconIndex == e.key
                                        ? AppColor.primaryColor
                                        : Colors.transparent,
                                borderRadius: 20.0,
                                boxShadow: controller.selectedIconIndex == e.key
                                    ? [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 1.0,
                                          blurRadius: 10.0,
                                        )
                                      ]
                                    : []),
                            child: controller.selectedIconIndex == e.key
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
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  controller.onClearCategory();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  debugPrint("below${controller.iconPath}");
                  if (controller.formKeyCategory.currentState!.validate()) {
                    if (controller.categoryTitle.isNotEmpty) {
                      controller.addCategory(CategoryModel(
                          id: DateTime.now().toString(),
                          icon: controller.iconPath,
                          title: controller.categoryTitle));
                      controller.onClearCategory();
                    }

                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }
}
