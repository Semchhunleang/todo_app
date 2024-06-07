import 'package:flutter/material.dart';

import '../../../utils/widgets/custom_card_icon_label.dart';

class ShowMoreWidget extends StatelessWidget {
  final GestureTapCallback? onTapEdit;
  final GestureTapCallback? onTapDelete;
  const ShowMoreWidget({super.key, this.onTapEdit, this.onTapDelete});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTapEdit ?? () {},
          child: const CustomCardIconLabel(
            icon: Icons.edit,
            title: 'Edit',
            isShowDivider: false,
          ),
        ),
        InkWell(
          onTap: onTapDelete ?? () {},
          child: const CustomCardIconLabel(
            icon: Icons.delete,
            title: 'Delete',
            iconColor: Colors.red,
          ),
        ),
      ],
    );
  }
}
