// ignore_for_file: camel_case_types, use_build_context_synchronously
import 'package:database_app/models/process_response.dart';
import 'package:database_app/provider/product_provider.dart';
import 'package:database_app/screens/app/products/product_screen.dart';
import 'package:database_app/shared_preferences/shared_preferences.dart';
import 'package:database_app/snakbars/context_extenssion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class Products_Screen extends StatefulWidget {
  const Products_Screen({Key? key}) : super(key: key);

  @override
  State<Products_Screen> createState() => _Products_ScreenState();
}

class _Products_ScreenState extends State<Products_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localization.products),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Product_Screen()),
              );
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              _confirmeLogoute();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
          builder: (context, ProductProvider value, child) {
        if (value.products.isNotEmpty) {
          return ListView.builder(
            itemCount: value.products.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.shop),
                title: Text(value.products[index].name),
                subtitle: Text(value.products[index].info),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => _deletProduct(index),
                        icon: const Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add_shopping_cart_outlined),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Product_Screen(
                        product: value.products[index],
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return Center(
            child: Text(
              'NO DATA',
              style: GoogleFonts.cairo(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          );
        }
      }),
    );
  }

  void _confirmeLogoute() async {
    bool? result = await showDialog<bool>(
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

    if (result ?? false) {
      bool remove =
          // await SharedPrefController().removeValueFor(savedata.logedInd.name);
          await SharedPrefController().claer();
      if (remove) {
        Navigator.pushReplacementNamed(context, '/login_screen');
      }
    }
  }

  void _deletProduct(int index) async {
    // ignore: non_constant_identifier_names
    processResponse Respons =
        await Provider.of<ProductProvider>(context, listen: false)
            .delete(index);

    context.showSnakBar(
      messageerroe: Respons.message,
      error: !Respons.success,
    );
  }
}
