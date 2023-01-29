import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class Change extends ChangeNotifier {
  bool refresh = false;

  set ref(v) {
    refresh = true;
    notifyListeners();
  }
}
