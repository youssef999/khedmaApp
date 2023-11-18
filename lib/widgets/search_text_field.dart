import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class SearchTextField extends StatelessWidget {
  SearchTextField({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.keyBoardType,
    this.obsecureText = false,
    this.readOnly = false,
    this.prefix,
    this.validator,
    this.onchanged,
    this.initialValue,
    this.controller,
    this.inputFormatters,
    this.padding = const EdgeInsets.only(left: 15, right: 15, top: 5),
    this.suffixIcon,
    this.textDirection,
    this.suffix,
    this.fillColor,
    this.textInputAction,
    this.autovalidateMode,
    this.width,
    this.height,
    this.focusNode,
    this.style,
    this.onTap,
    this.filterAction,
    this.borderRadius,
    this.border,
    this.textAlign = TextAlign.start,
  });
  final TextStyle? style;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Widget? suffix;
  final double? width;
  final double? height;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? keyBoardType;
  final String? Function(String? s)? validator;
  final String? initialValue;
  final TextEditingController? controller;
  final Function(String? s)? onchanged;
  List<TextInputFormatter>? inputFormatters;
  void Function()? filterAction;
  final Color? fillColor;
  bool obsecureText = false;
  final void Function()? onTap;
  bool readOnly = false;
  AutovalidateMode? autovalidateMode;
  EdgeInsetsGeometry? padding =
      const EdgeInsets.only(left: 15, right: 15, top: 5);
  TextDirection? textDirection;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: Colors.white),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: fillColor ?? const Color(0xffF8F8F8),
            borderRadius: borderRadius ?? BorderRadius.circular(15),
            border: border),
        width: width,
        height: height,
        child: TextFormField(
          textAlign: textAlign,
          autovalidateMode: autovalidateMode,
          onChanged: onchanged,
          initialValue: initialValue,
          obscureText: obsecureText,
          textInputAction: textInputAction,
          focusNode: focusNode,

          controller: controller,
          // cursorHeight: 3.0.sp,
          keyboardType: keyBoardType,

          style: style ?? GoogleFonts.poppins(fontSize: 15.0.sp),
          decoration: InputDecoration(
            border: InputBorder.none,
            iconColor: Colors.red,
            prefixIconColor: focusNode == null
                ? null
                : focusNode!.hasFocus
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.grey,
            suffixIconConstraints:
                const BoxConstraints(minHeight: 24, minWidth: 24),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            prefix: prefix,
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(
                fontSize: 13.0.sp, color: const Color(0xffAFAFAF)),
          ),

          validator: validator,
        ),
      ),
    );
  }
}
