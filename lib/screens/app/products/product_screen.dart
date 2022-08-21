// ignore_for_file: camel_case_types
import 'package:database_app/models/process_response.dart';
import 'package:database_app/models/product.dart';
import 'package:database_app/provider/product_provider.dart';
import 'package:database_app/shared_preferences/shared_preferences.dart';
import 'package:database_app/snakbars/context_extenssion.dart';
import 'package:database_app/widgets/test_filde_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Product_Screen extends StatefulWidget {
  const Product_Screen({Key? key, this.product}) : super(key: key);

  final Product? product;

  @override
  State<Product_Screen> createState() => _Product_ScreenState();
}

class _Product_ScreenState extends State<Product_Screen> {
  late TextEditingController _name;
  late TextEditingController _ifo;
  late TextEditingController _price;
  late TextEditingController _count;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.product?.name);
    _ifo = TextEditingController(text: widget.product?.info);
    _price = TextEditingController(text: widget.product?.price.toString());
    _count = TextEditingController(text: widget.product?.quantity.toString());
  }

  @override
  void dispose() {
    _name.dispose();
    _ifo.dispose();
    _price.dispose();
    _count.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titel),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        children: [
          Text(
            context.localization.create_products,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20.h),
          page_textfilde_widget(
            hint: context.localization.name,
            prefixIcon: (Icons.title),
            keporderTybe: TextInputType.text,
            controller: _name,
          ),
          SizedBox(height: 20.h),
          page_textfilde_widget(
            hint: context.localization.ifo,
            prefixIcon: (Icons.title),
            keporderTybe: TextInputType.text,
            controller: _ifo,
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: page_textfilde_widget(
                  hint: context.localization.price,
                  prefixIcon: (Icons.price_change),
                  keporderTybe: const TextInputType.numberWithOptions(
                      signed: false, decimal: true),
                  controller: _price,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: page_textfilde_widget(
                  hint: context.localization.quantity,
                  prefixIcon: (Icons.numbers),
                  keporderTybe: const TextInputType.numberWithOptions(
                      signed: false, decimal: true),
                  controller: _count,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: () => _performSave(),
            child: Text(context.localization.save),
          ),
        ],
      ),
    );
  }

  bool get isUpdateProduct => widget.product != null;

  String get titel => isUpdateProduct
      ? context.localization.update_products
      : context.localization.create_products;

  void _performSave() {
    if (_checkData()) {
      _save();
    }
  }

  bool _checkData() {
    if (_name.text.isNotEmpty &&
        _ifo.text.isNotEmpty &&
        _price.text.isNotEmpty &&
        _count.text.isNotEmpty) {
      return true;
    }
    context.showSnakBar(
      messageerroe: context.localization.error_data,
      error: true,
    );
    return false;
  }

  Future<void> _save() async {
    //TODO: Call Database save function from ProductProvider as (Intermediate) Layer  between UI & Controllers

    // ignore: non_constant_identifier_names
    processResponse ProcessResponse = isUpdateProduct
        ? await Provider.of<ProductProvider>(context, listen: false)
            .update(product)
        : await Provider.of<ProductProvider>(context, listen: false)
            .create(product);
    if (ProcessResponse.success) {
      clear();
    }
    // ignore: use_build_context_synchronously
    context.showSnakBar(
      messageerroe: ProcessResponse.message,
      error: !ProcessResponse.success,
    );

    if (ProcessResponse.success) {
      // ignore: use_build_context_synchronously
      isUpdateProduct ? Navigator.pop(context) : clear();
    }
  }

  Product get product {
    Product product = isUpdateProduct ? widget.product! : Product();
    product.name = _name.text;
    product.info = _ifo.text;
    product.price = double.parse(_price.text);
    product.quantity = int.parse(_count.text);
    product.userId = SharedPrefController().getValueFor<int>(savedata.id.name)!;
    return product;
  }

  void clear() {
    _name.clear();
    _ifo.clear();
    _price.clear();
    _count.clear();
  }
}
