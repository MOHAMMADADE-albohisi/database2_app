// ignore_for_file: camel_case_types
import 'package:shared_preferences/shared_preferences.dart';

enum savedata { language, email, logedInd }

class SharedPrefController {
  SharedPrefController._();

  late SharedPreferences _sharedPreferences;

  static SharedPrefController? _instancetest;

  factory SharedPrefController() {
    return _instancetest ??= SharedPrefController._();
  }

  Future<void> initPreferTest() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void saveemail({required String email}) {
    _sharedPreferences.setBool(savedata.logedInd.name, true);
    _sharedPreferences.setString(savedata.email.name, email);
  }

  void savelanguage({required String langchang}) {
    _sharedPreferences.setString(savedata.language.name, langchang);
  }

  T? getValueFor<T>(String key) {
    if (_sharedPreferences.containsKey(key)) {
      return _sharedPreferences.get(key) as T;
    }
    return null;
  }

  Future<bool> removeValueFor(String key) async {
    if (_sharedPreferences.containsKey(key)) {
      return _sharedPreferences.remove(key);
    }
    return false;
  }

  Future<bool> claer() {
    return _sharedPreferences.clear();
  }
}
