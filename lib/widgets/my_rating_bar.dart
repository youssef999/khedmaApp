import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

import '../Utils/utils.dart';

class MyRatingBar extends StatelessWidget {
  const MyRatingBar({
    super.key,
    required this.label,
    required this.value,
    required this.maxVal,
  });
  final String label;
  final double value;
  final double maxVal;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        coloredText(text: label, color: Theme.of(context).colorScheme.primary),
        spaceX(10),
        Expanded(
          child: FAProgressBar(
            size: 10,
            borderRadius: BorderRadius.circular(20),
            backgroundColor: const Color(0xffE9E9E9),
            progressColor: Theme.of(context).colorScheme.secondary,
            maxValue: maxVal,
            currentValue: value,
          ),
        ),
      ],
    );
  }
}
