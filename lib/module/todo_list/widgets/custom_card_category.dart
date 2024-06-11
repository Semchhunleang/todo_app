import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_list_app/core/extension.dart';

import '../../../constrant/constrants.dart';
import '../../../utils/properties_widget.dart';
import '../data/model/category/category_model.dart';

class CustomCardCategory extends StatelessWidget {
  final CategoryModel categoryModel;
  final int countItem;
  const CustomCardCategory(
      {super.key, required this.categoryModel, this.countItem = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: square(context) / (isIpad(context) ? 3 : 2),
      height: (square(context) / (isIpad(context) ? 3 : 2)) / 1.3,
      padding: const EdgeInsets.all(padding),
      decoration: boxShadowDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            categoryModel.icon,
            width: 19.0.sp,
            height: 19.0.sp,
            // colorFilter: const ColorFilter.mode(
            //   Colors.red,
            //   BlendMode.srcIn,
            // ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          Text(
            categoryModel.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            "$countItem Tasks",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
