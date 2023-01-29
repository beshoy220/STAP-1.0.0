// ignore: file_names
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> getIsFirstTimeToTrue() async {
  final prefs = await SharedPreferences.getInstance();
  bool finalPref = prefs.getBool('isFirstTime') ?? true;
  return finalPref;
}

setIsFirstTimeToFalse() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.setBool('isFirstTime', false);
}
