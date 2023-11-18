// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ZeroAppBar extends StatelessWidget implements PreferredSizeWidget {
  ZeroAppBar({super.key, this.color, this.gradient});
  Color? color;
  Gradient? gradient;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: color,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: gradient,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(0);
}
