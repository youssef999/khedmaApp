import 'package:flutter/animation.dart';

class MyChartData {
  final int? id;
  final String name;
  final double? y;
  final Color color;
  final double? percent;

  MyChartData({
    this.percent,
    this.id,
    required this.name,
    this.y,
    required this.color,
  });
}
