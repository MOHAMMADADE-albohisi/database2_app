import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

mixin Helpers {
  // ignore: non_constant_identifier_names
  void ShowSnakBar(BuildContext context,
      {required String messageerroe, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
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
