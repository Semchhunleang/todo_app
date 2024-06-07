import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/constrant/app_color.dart';
import '../../../utils/properties_widget.dart';
import 'add_category_widget.dart';

class CustomButtonAddCategory extends StatelessWidget {
  const CustomButtonAddCategory({super.key});

  @override
  Widget build(BuildContext context) {
    var squareWidth = Get.width - 45.0;
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AddCategoryWidget();
          },
        );
      },
      child: Container(
        width: squareWidth / 2,
        height: (squareWidth / 2) / 1.3,
        decoration: boxShadowDecoration(backgroundColor: AppColor.primaryColor),
        child: const Icon(
          Icons.add,
          size: 35.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
