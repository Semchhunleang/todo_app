import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constrant/constrants.dart';

class EmptyStateWidget extends StatelessWidget {
  final String imagePath;
  final String description;
  const EmptyStateWidget(
      {super.key, required this.description, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imagePath,
            width: 130.0,
            height: 130.0,
          ),
          const SizedBox(
            height: padding,
          ),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
    );
  }
}
