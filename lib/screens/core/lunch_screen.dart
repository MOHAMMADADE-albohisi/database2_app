import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class lunch_screen extends StatefulWidget {
  const lunch_screen({Key? key}) : super(key: key);

  @override
  State<lunch_screen> createState() => _lunch_screenState();
}

class _lunch_screenState extends State<lunch_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
          () {
        Navigator.pushReplacementNamed(context, '/login_screen');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.topEnd,
            colors: [
              Colors.pink.shade100,
              Colors.blue.shade100,
            ],
          ),
        ),
        child: Text(
          'Data App',
          style: GoogleFonts.cairo(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
