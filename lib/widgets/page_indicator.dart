import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    Key? key,
    this.currentValue = 0,
    required this.num,
  }) : super(key: key);
  final int currentValue;
  final int num;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        num,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: AnimatedContainer(
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 250),
            width: index == currentValue ? 35 : 10,
            height: 7,
            decoration: BoxDecoration(
              color: index == currentValue
                  ? Theme.of(context).colorScheme.secondary
                  : const Color(0xffE2EBF5),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
      ),
    );
  }
}
