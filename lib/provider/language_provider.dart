import 'package:database_app/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String language =
      SharedPrefController().getValueFor<String>(savedata.language.name) ?? 'en';

  // ignore: non_constant_identifier_names
  Future<void> changeLanguage(String Newlanguage) async {
    language = Newlanguage;
    SharedPrefController().savelanguage(langchang: language);
    notifyListeners();
  }
}
