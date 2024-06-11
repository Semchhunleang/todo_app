import 'package:flutter/material.dart';
import 'package:to_do_list_app/constrant/app_color.dart';
import 'package:to_do_list_app/constrant/constrants.dart';
import '../../../utils/properties_widget.dart';
import 'add_category_widget.dart';

class CustomButtonAddCategory extends StatelessWidget {
  const CustomButtonAddCategory({super.key});

  @override
  Widget build(BuildContext context) {
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
        width: square(context) / (isIpad(context) ? 3 : 2),
        height: (square(context) / (isIpad(context) ? 3 : 2)) / 1.3,
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
