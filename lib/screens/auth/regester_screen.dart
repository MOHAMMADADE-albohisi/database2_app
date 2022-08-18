import 'dart:io';

import 'package:database_app/database/controllers/user_db_controller.dart';
import 'package:database_app/models/process_response.dart';
import 'package:database_app/models/user.dart';
import 'package:database_app/snakbars/context_extenssion.dart';
import 'package:database_app/snakbars/helpin_screen.dart';
import 'package:database_app/widgets/test_filde_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class register_screen extends StatefulWidget {
  const register_screen({Key? key}) : super(key: key);

  @override
  State<register_screen> createState() => _register_screenState();
}

// ignore: camel_case_types
class _register_screenState extends State<register_screen> with Helpers {
  late TextEditingController _name;
  late TextEditingController _email;
  late TextEditingController _password;
  late bool showpasssword = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.register),
        actions: [],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.register_title,
              style: GoogleFonts.cairo(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              AppLocalizations.of(context)!.regester_subtitle,
              style: GoogleFonts.cairo(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 15.h),
            page_textfilde_widget(
              hint: AppLocalizations.of(context)!.email,
              showpasssword: false,
              prefixIcon: Icons.email,
              keporderTybe: TextInputType.emailAddress,
              controller: _email,
            ),
            SizedBox(height: 10.h),
            page_textfilde_widget(
              hint: AppLocalizations.of(context)!.name,
              showpasssword: false,
              prefixIcon: Icons.person_outlined,
              keporderTybe: TextInputType.name,
              controller: _name,
            ),
            SizedBox(height: 10.h),
            page_textfilde_widget(
              showpasssword: showpasssword,
              hint: AppLocalizations.of(context)!.password,
              prefixIcon: Icons.lock,
              keporderTybe: TextInputType.text,
              controller: _password,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() => showpasssword = !showpasssword);
                },
                icon: const Icon(Icons.visibility),
              ),
            ),
            SizedBox(height: 10.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  )),
              onPressed: () => registerperform(),
              child: Text(
                AppLocalizations.of(context)!.register,
                style: GoogleFonts.cairo(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> registerperform() async {
    if (_checData()) {
      await _register();
    }
  }

  bool _checData() {
    if (_email.text.isNotEmpty &&
        _name.text.isNotEmpty &&
        _password.text.isNotEmpty) {
      return true;
    }
    ShowSnakBar(context,
        messageerroe: AppLocalizations.of(context)!.error, error: true);
    return false;
  }

  Future<void> _register() async {
    /// TODO: Call database register function
    processResponse ProcessResponse =
        await UserDbController().register(user: user);
    if (ProcessResponse.success) {
      Navigator.pop(context);
    }
    // ignore: use_build_context_synchronously
    context.showSnakBar(
      messageerroe: ProcessResponse.message,
      error: !ProcessResponse.success,
    );
  }

  User get user {
    User user = User();
    user.name = _name.text;
    user.email = _email.text;
    user.password = _password.text;
    return user;
  }
}
