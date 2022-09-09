import 'package:database_app/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageGetxController extends GetxController {
  String language = SharedPrefController().getValueFor<String>(savedata.language.name) ?? 'en';
  RxString languages = ''.obs;

  static LanguageGetxController get to => Get.find<LanguageGetxController>();

  @override
  void onInit() {
    languages.value = language;
    super.onInit();
  }

  // ignore: non_constant_identifier_names
  Future<void> changeLanguage(String Newlanguage) async {
    language = Newlanguage;
    SharedPrefController().savelanguage(langchang: language);
  }
}
