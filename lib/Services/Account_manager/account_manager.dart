import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Accounts {
  final storage = const FlutterSecureStorage();

  saveUserPasswordAndId(String emailId, String password) {
    storage.read(key: 'Accounts').then((value) {
      if (value == null) {
        storage.write(key: 'Accounts', value: '$emailId  &&  $password');
        debugPrint('First User');
      } else {
        if (value.contains(emailId)) {
          for (var i = 0; i < value.split('  ||  ').length; i++) {
            if (value.split('  ||  ')[i].contains(emailId)) {
              storage.write(
                  key: 'Accounts',
                  value: value.split('  ||  ')[i] = '$emailId  &&  $password' +
                      '  ||  ${value.split('  ||  ').removeAt(i)}');
              // print(value.split('  ||  ').removeAt(i));
              // debugPrint('User Existed & Changed Password');
            } else {
              // CODE TO EXCUITE
            }
          }
        } else {
          storage.write(
              key: 'Accounts', value: '$value  ||  $emailId  &&  $password');
          debugPrint('User Add');
        }
      }
    });
  }

  Future readAllSavedUsers() {
    return storage.read(key: 'Accounts');
  }

  deleteAll() {
    storage.deleteAll();
  }
}
