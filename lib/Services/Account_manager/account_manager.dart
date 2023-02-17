import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Accounts {
  final storage = const FlutterSecureStorage();

  saveUserPasswordAndId(String emailId, String password) {
    storage.write(
        key: 'Accounts',
        value: jsonEncode({
          '0': {'email': emailId, 'password': password}
        }));
    debugPrint('first user');
  }

  Future<dynamic> readAllSavedUsers() {
    return storage.readAll();
  }

  deleteAll() {
    storage.deleteAll();
  }
}
