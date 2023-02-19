import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Accounts {
  final storage = const FlutterSecureStorage();

  saveUserPasswordAndId(String emailId, String password) {
    storage.read(key: 'Accounts').then((value) {
      if (value == null) {
        storage.write(key: 'Accounts', value: [emailId, password].toString());
        debugPrint('first user');
      } else {
        storage.write(key: 'Accounts', value: [emailId, password].toString());
        debugPrint('update first user');
        // if (value.split(' && ')[0] == [emailId, password].toString()) {
        //   debugPrint('User already saved 1');
        // } else {
        //   // storage.write(
        //   //     key: 'Accounts', value: '$value && ${[emailId, password]}');
        //   // debugPrint('Another user');
        // }
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
