import 'package:flutter/material.dart';
import 'package:to_do_list_app/constrant/app_color.dart';

onShowBottomSheet({
  BuildContext? context,
  String? title,
  Function? onTab,
  Widget? child,
  double? height,
  Color? colors,
  EdgeInsets? padding,
  Color? doneTextColor,
  bool? isWidget = false,
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: context!,
    constraints: const BoxConstraints(
      maxWidth: double.infinity,
    ),
    builder: (context) {
      return Container(
        padding: padding,
        height: height ?? 250,
        child: Column(
          children: [
            Container(
              //   padding: const EdgeInsets.only(right: 20),
              //margin: const EdgeInsets.only(left: 20),
              height: 40,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),

              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    if (onTab != null) {
                      onTab();
                    }
                    Navigator.pop(context);
                  },
                  child: Text(
                    title ?? "Done",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: AppColor.primaryColor),
                  ),
                ),
              ),
            ),
            if (isWidget == false)
              Expanded(
                // child: SingleChildScrollView(
                //   scrollDirection: Axis.vertical,
                child: Container(
                  child: child,
                ),
              ),
          ],
        ),
      );
    },
  );
}
