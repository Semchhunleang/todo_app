import 'package:flutter/material.dart';
import 'package:to_do_list_app/constrant/constrants.dart';

import '../../constrant/app_color.dart';

class CustomCardIconLabel extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isShowDivider;
  final Color? iconColor;

  const CustomCardIconLabel(
      {super.key,
      required this.icon,
      required this.title,
      this.isShowDivider = true,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(
            color: Color.fromARGB(255, 210, 214, 222),
          ),
          bottom: isShowDivider
              ? const BorderSide(
                  color: Color.fromARGB(255, 210, 214, 222),
                )
              : BorderSide(color: Colors.grey.shade300, width: 0.0),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor ?? AppColor.primaryColor,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
            // fontWeight: FontWeight.w600,
            // fontSize: subtitleFontSize,
            // color: blackColor,
          ),
        ],
      ),
    );
  }
}
