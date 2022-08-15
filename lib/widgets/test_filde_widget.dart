import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class page_textfilde_widget extends StatelessWidget {
  const page_textfilde_widget({
    Key? key,
    required this.hint,
    required this.prefixIcon,
    required this.keporderTybe,
    required this.controller,
    this.colorss = Colors.grey,
    this.suffixIcon,
    required this.showpasssword,
  }) : super(key: key);

  final String hint;
  final IconData prefixIcon;
  final TextInputType keporderTybe;
  final TextEditingController controller;
  final Color colorss;
  final Widget? suffixIcon;
  final bool showpasssword;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keporderTybe,
      style: GoogleFonts.cairo(fontSize: 13.sp),
      obscureText: showpasssword,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: hint,
        hintStyle: GoogleFonts.cairo(fontSize: 13.sp),
        hintMaxLines: 1,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon,
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(color: colorss),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({Color color = Colors.grey}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(color: color),
    );
  }
}
