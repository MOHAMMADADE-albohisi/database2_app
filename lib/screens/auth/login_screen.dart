import 'package:database_app/database/controllers/user_db_controller.dart';
import 'package:database_app/models/process_response.dart';
import 'package:database_app/provider/language_provider.dart';
import 'package:database_app/shared_preferences/shared_preferences.dart';
import 'package:database_app/snakbars/context_extenssion.dart';
import 'package:database_app/snakbars/helpin_screen.dart';
import 'package:database_app/widgets/test_filde_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

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
  late String _language;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _language =
        SharedPrefController().getValueFor(savedata.language.name) ?? 'en';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.new_account),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/register_screen'),
                  child: Text(AppLocalizations.of(context)!.register),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showLanguage() async {
    String? langchangetest = await showModalBottomSheet<String>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      context: (context),
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return StatefulBuilder(
              builder: ((context, setState) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
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
                      const Divider(),
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
                            Navigator.pop(context, 'en');
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
                            Navigator.pop(context, 'ar');
                          }
                        },
                      ),
                      RadioListTile<String>(
                        title: Text(
                          'Français',
                          style: GoogleFonts.cairo(),
                        ),
                        value: 'fa',
                        groupValue: _language,
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() => _language = value);
                            Navigator.pop(context, 'fa');
                          }
                        },
                      ),
                    ],
                  ),
                );
              }),
            );
          },
        );
      },
    );

    if (langchangetest != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Provider.of<LanguageProvider>(context, listen: false)
            .changeLanguage(langchangetest);
      });
    }
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

  void login() async {
    processResponse ProcessResponse = await UserDbController()
        .login(email: _email.text, password: _password.text);
    if (ProcessResponse.success) {
      Navigator.pushReplacementNamed(context, '/home_screen');
    }
    context.showSnakBar(
      messageerroe: ProcessResponse.message,
      error: !ProcessResponse.success,
    );
  }
}
