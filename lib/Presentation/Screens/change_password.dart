import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_manager/App/meta.dart';
import 'package:school_manager/Data/Firebase/authentication.dart';
import 'package:school_manager/Data/Local_providers/options_operations.dart';
import 'package:school_manager/Presentation/Screens/report_error.dart';
import 'package:school_manager/Services/Account_manager/account_manager.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool verificationSend = false;

  TextEditingController writepasswordController = TextEditingController();
  TextEditingController rewritepasswordController = TextEditingController();

  String errorMessage = '';
  bool _showPassword = true;
  bool _showPassword2 = true;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _togglevisibility2() {
    setState(() {
      _showPassword2 = !_showPassword2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting New Password'.tr()),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Text(
                  AppMeta.appName,
                  style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Setting New Password'.tr(),
                  style: const TextStyle(fontSize: 20),
                )),
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: _showPassword,
                      controller: writepasswordController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Enter The New Password'.tr(),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _togglevisibility();
                          },
                          child: Icon(
                            !_showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppMeta.color,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: _showPassword2,
                      controller: rewritepasswordController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Re-Enter The New Password'.tr(),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _togglevisibility2();
                          },
                          child: Icon(
                            !_showPassword2
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppMeta.color,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Center(
                        child: Text(
                            'After you fill the inputs up click the Button down'
                                .tr())),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        child: Text('Save The Password'.tr()),
                        onPressed: () {
                          if (writepasswordController.text ==
                                  rewritepasswordController.text &&
                              rewritepasswordController.text.length >= 8) {
                            Auth()
                                .updatePassword(rewritepasswordController.text)
                                .then((value) {
                              Accounts().saveUserPasswordAndId(
                                  Auth().currentUser!.email as String,
                                  rewritepasswordController.text);
                              Navigator.pop(context);

                              final snackBar = SnackBar(
                                content: Text('Password Saved'.tr()),
                                action: SnackBarAction(
                                  label: 'Okay'.tr(),
                                  onPressed: () {},
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }).onError((error, stackTrace) {
                              setState(() {
                                errorMessage = error.toString();
                              });
                            });
                          }
                        },
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('For any bugs contact us'.tr()),
                TextButton(
                  child: Text(
                    'Contact'.tr(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    NavigateTo(context, const ReportError());
                  },
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Center(child: Text('V ${AppMeta.version}')),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
