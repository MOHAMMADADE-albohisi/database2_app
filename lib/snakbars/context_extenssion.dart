import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension ContexHelper on BuildContext{
  void showSnakBar({required String messageerroe, bool error = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          messageerroe,
          style: GoogleFonts.cairo(),
        ),
        backgroundColor: error ? Colors.red.shade700 : Colors.blue.shade300,
        duration: const Duration(seconds: 3),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }
}