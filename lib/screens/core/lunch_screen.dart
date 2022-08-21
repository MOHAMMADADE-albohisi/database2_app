import 'package:database_app/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class lunch_screen extends StatefulWidget {
  const lunch_screen({Key? key}) : super(key: key);

  @override
  State<lunch_screen> createState() => _lunch_screenState();
}

// ignore: camel_case_types
class _lunch_screenState extends State<lunch_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        bool loggedIn =
            SharedPrefController().getValueFor<bool>(savedata.logedInd.name) ?? false;
        String routes = loggedIn ? '/Products_Screen ' : '/login_screen';
        Navigator.pushReplacementNamed(context, routes);
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
