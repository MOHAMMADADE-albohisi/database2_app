import 'package:database_app/get/cart_getx_contorller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          IconButton(
            onPressed: () {
              CartGetxContriller.to.clear();
            },
            icon: const Icon(Icons.delete_outline),
          )
        ],
      ),
      body: GetX<CartGetxContriller>(
        builder: (CartGetxContriller controller) {
          if (controller.cartsItems.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: controller.cartsItems.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 90,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 10.h,
                      ),
                      padding:
                          EdgeInsetsDirectional.only(start: 15.w, end: 5.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 0),
                              color: Colors.black54,
                              blurRadius: 4,
                            )
                          ]),
                      child: Stack(
                        children: [
                          PositionedDirectional(
                            end: 0,
                            top: 0,
                            child: IconButton(
                              onPressed: () {
                                CartGetxContriller.to.changeQuantity(index, 0);
                              },
                              icon: const Icon(Icons.close),
                              color: Colors.red,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.shopping_cart),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.cartsItems[index].productName,
                                      style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Text(
                                      'Quantity: ${controller.cartsItems[index].count} - Total: ${controller.cartsItems[index].total}',
                                      style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12.sp,
                                        height: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      CartGetxContriller.to.changeQuantity(
                                          index,
                                          controller.cartsItems[index].count +
                                              1);
                                    },
                                    icon: const Icon(Icons.add),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      CartGetxContriller.to.changeQuantity(
                                          index,
                                          controller.cartsItems[index].count -
                                              1);
                                    },
                                    icon: const Icon(Icons.remove),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                  color: Colors.grey.shade200,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Total:',
                            style: GoogleFonts.cairo(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text(
                            controller.total.toString(),
                            style: GoogleFonts.cairo(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text(
                            'quantity:',
                            style: GoogleFonts.cairo(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text(
                            controller.quantity.toString(),
                            style: GoogleFonts.cairo(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text(
                'CART IS EMPTY',
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
