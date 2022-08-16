import 'package:database_app/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String language =
      SharedPreftest().getValueFor<String>(savedata.language.name) ?? 'en';

  void changeLanguage(String Newlanguage) {
    language = Newlanguage;
    SharedPreftest().savelanguage(langchang: language);
    notifyListeners();
  }
}
