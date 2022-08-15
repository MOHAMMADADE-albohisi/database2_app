import 'package:database_app/snakbars/helpin_screen.dart';
import 'package:database_app/widgets/test_filde_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: camel_case_types
class login_screen extends StatefulWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  State<login_screen> createState() => _login_screenState();
}

// ignore: camel_case_types
class _login_screenState extends State<login_screen> with Helpers {
  late TextEditingController _email;
  late TextEditingController _password;
  late bool showpasssword = true;
  String _language = 'en';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.login),
        actions: [
          IconButton(
            onPressed: () {
              _showLanguage();
            },
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.login_title,
              style: GoogleFonts.cairo(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              AppLocalizations.of(context)!.login_subtitle,
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
              onPressed: () => performlogin(),
              child: Text(
                AppLocalizations.of(context)!.login,
                style: GoogleFonts.cairo(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguage() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(15),
        topLeft: Radius.circular(15),
      )),
      clipBehavior: Clip.antiAlias,
      context: (context),
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return StatefulBuilder(builder: ((context, setState) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.language_title,
                      style: GoogleFonts.cairo(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      AppLocalizations.of(context)!.languagesub_title,
                      style: GoogleFonts.cairo(
                          height: 1.0,
                          fontSize: 14.sp,
                          color: Colors.black54,
                          fontWeight: FontWeight.w300),
                    ),
                    Divider(),
                    RadioListTile<String>(
                      title: Text(
                        'English',
                        style: GoogleFonts.cairo(),
                      ),
                      value: 'en',
                      groupValue: _language,
                      onChanged: (String? value) {
                        if (value != null) {
                          setState(() => _language = value);
                        }
                      },
                    ),
                    RadioListTile<String>(
                      title: Text(
                        'العربية',
                        style: GoogleFonts.cairo(),
                      ),
                      value: 'ar',
                      groupValue: _language,
                      onChanged: (String? value) {
                        if (value != null) {
                          setState(() => _language = value);
                        }
                      },
                    ),
                  ],
                ),
              );
            }));
          },
        );
      },
    );
  }

  void performlogin() {
    if (_checData()) {
      login();
    }
  }

  bool _checData() {
    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
      return true;
    }
    ShowSnakBar(context,
        messageerroe: AppLocalizations.of(context)!.error, error: true);
    return false;
  }

  void login() {
    Navigator.pushReplacementNamed(context, '/home_screen');
  }
}
