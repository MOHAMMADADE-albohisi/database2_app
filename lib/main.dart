// ignore_for_file: camel_case_types
import 'package:database_app/database/db_controller.dart';
import 'package:database_app/provider/cart_provider.dart';
import 'package:database_app/provider/language_provider.dart';
import 'package:database_app/provider/product_provider.dart';
import 'package:database_app/screens/app/cart/cart_screen.dart';
import 'package:database_app/screens/app/products/Products_Screen.dart';
import 'package:database_app/screens/auth/login_screen.dart';
import 'package:database_app/screens/auth/regester_screen.dart';
import 'package:database_app/screens/core/lunch_screen.dart';
import 'package:database_app/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPreferTest();
  await DbController().initDatabase();
  runApp(const database_app());
}

class database_app extends StatelessWidget {
  const database_app({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiProvider(
            providers: [
              ChangeNotifierProvider<LanguageProvider>(
                  create: (context) => LanguageProvider()),
              ChangeNotifierProvider<ProductProvider>(
                  create: (context) => ProductProvider()),
              ChangeNotifierProvider<CartProvider>(
                  create: (context) => CartProvider()),
            ],
            builder: (context, widget) {
              return MaterialApp(
                theme: ThemeData(
                  appBarTheme: AppBarTheme(
                    centerTitle: true,
                    elevation: 0,
                    color: Colors.transparent,
                    iconTheme: const IconThemeData(color: Colors.black54),
                    titleTextStyle: GoogleFonts.cairo(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      color: Colors.black54,
                    ),
                  ),
                ),
                debugShowCheckedModeBanner: false,
                //******************** LOCALIZATION START ********************
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],

                supportedLocales: const [
                  Locale('ar'),
                  Locale('en'),
                  Locale('fa'),
                ],
                locale: Locale(Provider.of<LanguageProvider>(context).language),
                //******************** LOCALIZATION END ********************
                initialRoute: '/lunch_screen',
                routes: {
                  '/lunch_screen': (context) => const lunch_screen(),
                  '/login_screen': (context) => const login_screen(),
                  '/register_screen': (context) => const register_screen(),
                  '/Products_Screen ': (context) => const Products_Screen(),
                  '/cart_screen': (context) => const CartScreen(),
                },
              );
            });
      },
    );
  }
}
