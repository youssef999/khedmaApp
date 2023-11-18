// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Utils/utils.dart';

class MyRadioButton extends StatefulWidget {
  MyRadioButton({
    super.key,
    this.value,
    this.groupValue,
    this.onChanged,
    required this.text,
    required this.color,
    this.size,
  });
  final dynamic value;
  final dynamic groupValue;
  final void Function(dynamic)? onChanged;
  final String text;
  final double? size;
  Color color;

  @override
  State<MyRadioButton> createState() => _MyRadioButtonState();
}

class _MyRadioButtonState extends State<MyRadioButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
          // height: 20,
          child: Radio(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: widget.value,
            groupValue: widget.groupValue,
            onChanged: widget.onChanged,
            fillColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.black.withOpacity(.32);
              } else if (states.contains(MaterialState.selected)) {
                return widget.color;
              } else {
                return const Color(0xff707070);
              }
            }),
          ),
        ),
        spaceX(10),
        Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child:
              // widget.groupValue == widget.value
              //     ? coloredText(
              //         text: widget.text,
              //         fontSize: widget.size ?? 14.0.sp,
              //         color: Colors.black)
              //     :
              coloredText(
                  text: widget.text,
                  fontSize: widget.size ?? 14.0.sp,
                  color: const Color(0xff707070)),
        )
      ],
    );
  }
}
