// ignore_for_file: camel_case_types, use_build_context_synchronously
import 'package:database_app/get/cart_getx_contorller.dart';
import 'package:database_app/get/product_getx_contorller.dart';
import 'package:database_app/models/cart.dart';
import 'package:database_app/models/process_response.dart';
import 'package:database_app/models/product.dart';
import 'package:database_app/screens/app/products/product_screen.dart';
import 'package:database_app/shared_preferences/shared_preferences.dart';
import 'package:database_app/snakbars/context_extenssion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class products_screen extends StatelessWidget {
  /*const*/ products_screen({Key? key}) : super(key: key);

  // final ProductGetxController controller = Get.put<ProductGetxController>(ProductGetxController());
  final CartGetxContriller controller =
      Get.put<CartGetxContriller>(CartGetxContriller());

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
              _confirmeLogoute(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cart_screen');
        },
        child: const Icon(Icons.shopping_cart),
      ),
      body: GetBuilder<ProductGetxController>(
        init: ProductGetxController(),
        global: true,
        builder: (ProductGetxController controller) {
          if (controller.products.isNotEmpty) {
            return ListView.builder(
              itemCount: controller.products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.shop),
                  title: Text(controller.products[index].name),
                  subtitle: Text(controller.products[index].info),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => _deletProduct(context, index),
                          icon: const Icon(Icons.delete),
                        ),
                        IconButton(
                          onPressed: () {
                            CartGetxContriller.to
                                .create(getCart(controller.products[index]));
                          },
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
                          product: controller.products[index],
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
        },
      ),
    );
  }

  Cart getCart(Product product) {
    Cart cart = Cart();
    cart.productId = product.id;
    cart.price = product.price;
    cart.total = product.price;
    cart.userId = SharedPrefController().getValueFor<int>(savedata.id.name)!;
    cart.count = 1;
    cart.productName = product.name;
    return cart;
  }

  void _confirmeLogoute(BuildContext context) async {
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
        Get.delete<ProductGetxController>();
        Get.delete<CartGetxContriller
        >();
        Navigator.pushReplacementNamed(context, '/login_screen');
      }
    }
  }

  void _deletProduct(BuildContext context, int index) async {
    // ignore: non_constant_identifier_names
    processResponse Respons = await ProductGetxController.to.delete(index);

    context.showSnakBar(
      messageerroe: Respons.message,
      error: !Respons.success,
    );
  }
}
