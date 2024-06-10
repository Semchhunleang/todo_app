import 'dart:io';

import 'package:flutter/material.dart';

//App bar custom
AppBar customAppBar({
  BuildContext? context,
  GestureTapCallback? onPressed,
  Color? backgroundColor,
  String title = "",
  TextStyle? style,
  Color leadingColor = Colors.white,
  List<Widget>? actions,
  bool isLeading = true,
  Color titleColor = Colors.white,
}) {
  return AppBar(
    leading: isLeading
        ? IconButton(
            icon: Align(
                alignment: Alignment.center,
                child: Icon(
                  Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                  color: leadingColor,
                )),
            onPressed: onPressed ?? () {},
          )
        : null,
    backgroundColor:
        backgroundColor ?? Theme.of(context!).colorScheme.inversePrimary,
    title: Text(
      title,
      style: style ??
          Theme.of(context!)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.w600, color: titleColor),
    ),
    actions: actions ?? [],
  );
}
