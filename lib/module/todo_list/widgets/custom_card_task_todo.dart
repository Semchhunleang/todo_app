import 'package:flutter/material.dart';
import 'package:to_do_list_app/constrant/app_color.dart';

import '../../../utils/properties_widget.dart';

class CustomCardTaskTodo extends StatelessWidget {
  final String? label;
  final GestureTapCallback? onTapMore;
  final GestureTapCallback? onTapComplete;
  final bool isComplete;
  const CustomCardTaskTodo(
      {super.key,
      this.label,
      this.onTapMore,
      this.onTapComplete,
      this.isComplete = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10.0),
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 60.0,
              decoration: boxShadowDecoration(),
              child: Row(
                children: [
                  IconButton(
                    onPressed: onTapComplete,
                    icon: Icon(
                      isComplete
                          ? Icons.check_circle_outline
                          : Icons.circle_outlined,
                      color: isComplete ? Colors.green : Colors.grey,
                    ),
                  ),
                  Text(
                    label == null ? "" : "$label",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColor.textColor,
                        decoration:
                            isComplete ? TextDecoration.lineThrough : null),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: onTapMore,
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // IconButton(
          //   onPressed: onTapEdit,
          //   icon: Icon(
          //     Icons.edit,
          //     color: AppColor.primaryColor,
          //   ),
          // ),
          // IconButton(
          //   onPressed: onTapDelete,
          //   icon: const Icon(
          //     Icons.delete,
          //     color: Colors.red,
          //   ),
          // ),
        ],
      ),
    );
  }
}
