import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:school_manager/App/meta.dart';
import 'package:school_manager/Data/Local_providers/options_operations.dart';
import 'package:school_manager/Presentation/Screens/report_error.dart';

class ForgetStudentId extends StatefulWidget {
  const ForgetStudentId({super.key});

  @override
  State<ForgetStudentId> createState() => _ForgetStudentIdState();
}

class _ForgetStudentIdState extends State<ForgetStudentId> {
  bool verificationSend = false;

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
              child: verificationSend
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextField(
                            // obscureText: true,
                            // controller: rewritepasswordController,
                            keyboardType: TextInputType.number,

                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Enter The Recived Code'.tr(),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextField(
                            // obscureText: true,
                            // controller: rewritepasswordController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Enter The New Password'.tr(),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextField(
                            // obscureText: true,
                            // controller: rewritepasswordController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Re-Enter The New Password'.tr(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              child: Text('Save The Password'.tr()),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )),
                      ],
                    )
                  : Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            // controller: schoolCodeController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'School Code'.tr(),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextField(
                            // obscureText: true,
                            // controller: passwordController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Student/Teacher ID'.tr(),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: InternationalPhoneNumberInput(
                            locale: (context.locale == const Locale('en', 'US'))
                                ? 'en_US'
                                : 'ar_EG',
                            onInputChanged: (PhoneNumber number) {
                              // print(number.phoneNumber);
                            },
                            onInputValidated: (bool value) {
                              // print(value);
                            },
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            ignoreBlank: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            // selectorTextStyle:
                            //     const TextStyle(color: Colors.black),
                            initialValue: PhoneNumber(isoCode: 'EG'),
                            // textFieldController: controller,
                            formatInput: false,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            inputBorder: const OutlineInputBorder(),
                            onSaved: (PhoneNumber number) {
                              // print('On Saved: $number');
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Center(
                              child: Text(
                                  'After you fill the inputs up click the Button down'
                                      .tr())),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                              height: 50,
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: ElevatedButton(
                                child:
                                    Text('Send me the verification code'.tr()),
                                onPressed: () {
                                  setState(() {
                                    verificationSend = true;
                                  });
                                },
                              )),
                        )
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