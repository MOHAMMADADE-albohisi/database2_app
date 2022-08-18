// ignore_for_file: camel_case_types

import 'package:database_app/snakbars/context_extenssion.dart';
import 'package:database_app/widgets/test_filde_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Product_Screen extends StatefulWidget {
  const Product_Screen({Key? key}) : super(key: key);

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
    _name = TextEditingController();
    _ifo = TextEditingController();
    _price = TextEditingController();
    _count = TextEditingController();
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
        title: Text(context.localization.create_products),
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
            controller: _name,
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: page_textfilde_widget(
                  hint: context.localization.price,
                  prefixIcon: (Icons.title),
                  keporderTybe: const TextInputType.numberWithOptions(
                      signed: false, decimal: true),
                  controller: _name,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: page_textfilde_widget(
                  hint: context.localization.quantity,
                  prefixIcon: (Icons.title),
                  keporderTybe: const TextInputType.numberWithOptions(
                      signed: false, decimal: true),
                  controller: _name,
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

  void _performSave() {
    if (_checkData()) {
      save;
    }
  }

  bool _checkData() {
    return false;
  }

  Future<void> save() async {}
}
