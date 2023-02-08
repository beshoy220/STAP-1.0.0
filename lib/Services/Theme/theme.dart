import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModel extends ChangeNotifier {
  bool isDark = false;
  late bool themeFromPrefIsDark =
      themeFromSharedPref().then((value) => isDark = value) as bool;

  set changeTheme(bool value) {
    isDark = value;
    switchTheme();
    notifyListeners();
  }

  Future themeFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final getTheme = prefs.getBool('isDark_key') ?? false;
    return getTheme;
  }

  switchTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final getTheme = prefs.getBool('isDark_key') ?? false;
    switch (getTheme) {
      case true:
        prefs.setBool('isDark_key', false);
        break;
      case false:
        prefs.setBool('isDark_key', true);
        break;
    }
  }

  bool refresh = false;

  set ref(v) {
    refresh = true;
    notifyListeners();
  }
}
