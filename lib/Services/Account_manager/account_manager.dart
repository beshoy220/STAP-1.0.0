import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Accounts {
  final storage = const FlutterSecureStorage();

  saveUserPasswordAndId(String emailId, String password) {
    storage.read(key: 'Accounts').then((value) {
      if (value == null) {
        storage.write(key: 'Accounts', value: '$emailId  &&  $password');
        debugPrint('first user');
      } else {
        if (value == '$emailId  &&  $password') {
          debugPrint('User Existed');
        } else {
          storage.write(
              key: 'Accounts', value: '$value  ||  $emailId  &&  $password');
          debugPrint('User updated');
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
