// ignore_for_file: camel_case_types, use_build_context_synchronously
import 'package:database_app/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class home_screen extends StatefulWidget {
  const home_screen({Key? key}) : super(key: key);

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.home),
        actions: [
          IconButton(
            onPressed: () {
              _confirmeLogoute();
              // Navigator.pushReplacementNamed(context, '/login_screen');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }

  void _confirmeLogoute() async {
    bool? test = await showDialog<bool>(
      //***********************************************
      //لعدم اغلاق الايقونة من الضغط خارجها
      // barrierDismissible: false,
      //للتحكم بلون الخلفية
      // barrierColor: Colors.red.shade300.withOpacity(0.5),
      //***********************************************

      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.logut,
            style: GoogleFonts.cairo(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          content: Text(
            AppLocalizations.of(context)!.sublogute,
            style: GoogleFonts.cairo(
              fontSize: 13,
              color: Colors.black45,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(
                AppLocalizations.of(context)!.confarm,
                style: GoogleFonts.cairo(
                  fontSize: 12,
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(
                AppLocalizations.of(context)!.cancel,
                style: GoogleFonts.cairo(
                  fontSize: 12,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
    if (test ?? false) {
      bool remove =
          // await SharedPrefController().removeValueFor(savedata.logedInd.name);
          await SharedPrefController().claer();
      if (remove) {
        Navigator.pushReplacementNamed(context, '/login_screen');
      }
    }
  }
}
