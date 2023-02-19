import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:school_manager/App/meta.dart';
import 'package:school_manager/Data/Firebase/authentication.dart';
import 'package:school_manager/Data/Local_providers/options_operations.dart';
import 'package:school_manager/Presentation/Screens/home_panal.dart';
import 'package:school_manager/Presentation/Screens/teacher_panel.dart';
import 'package:school_manager/Presentation/Screens/welcome_sign_in_page.dart';
import 'package:school_manager/Services/Account_manager/account_manager.dart';

class AccountMaanger extends StatelessWidget {
  const AccountMaanger({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppMeta.color,
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      AppMeta.appName,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                const SizedBox(
                  height: 30,
                ),
                const Icon(
                  Icons.account_circle_outlined,
                  color: Colors.white,
                  size: 50,
                ),
                Text(
                  'Account Manager'.tr(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 22),
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: Accounts().readAllSavedUsers(),
                  initialData: {},
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    print(snapshot.data);
                    Map map = snapshot.data as Map;
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              (map['Accounts'].split(' && ') as List).length,
                          itemBuilder: (BuildContext context, int index) {
                            List list = map['Accounts'].split(' && ') as List;
                            String emailId = list[index]
                                .split(' , ')
                                .first
                                .split('@')
                                .first
                                .split('[')
                                .last;
                            String schoolCode = list[index]
                                .split(' , ')
                                .first
                                .split('@')
                                .last
                                .split(',')
                                .first;

                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: InkWell(
                                onTap: () {
                                  switch (emailId.toString().split('-').first) {
                                    case 'pt':
                                      Auth()
                                          .signInWithEmailAndPassword(
                                              email: list[index]
                                                  .split(',')
                                                  .first
                                                  .split('[')
                                                  .last
                                                  .trim(),
                                              password: list[index]
                                                  .split(',')
                                                  .last
                                                  .split(']')
                                                  .first
                                                  .trim())
                                          .then((value) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ParentPanel()),
                                        );
                                      });
                                      break;
                                    case 'tc':
                                      Auth()
                                          .signInWithEmailAndPassword(
                                              email: list[index]
                                                  .split(',')
                                                  .first
                                                  .split('[')
                                                  .last
                                                  .trim(),
                                              password: list[index]
                                                  .split(',')
                                                  .last
                                                  .split(']')
                                                  .first
                                                  .trim())
                                          .then((value) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const TeacherPanal()),
                                        );
                                      });
                                      break;
                                  }
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(37, 255, 255, 255),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          flex: 1,
                                          child: Icon(
                                            Icons.account_circle_outlined,
                                            color: Colors.white,
                                            size: 50,
                                          ),
                                        ),
                                        Expanded(
                                            flex: 4,
                                            child: Text(
                                              'School code :  $emailId \nAccount ID: $schoolCode  \n\nPassword : *********** ',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center();
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomeSingInMobile()),
                      );
                      // Accounts().deleteAll();
                      // Accounts().saveUserPasswordAndId(
                      //     'tc-20@school.com', '3038083031234');
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(37, 255, 255, 255),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Container(
                                        color: Colors.white10,
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 40,
                                        )),
                                  ],
                                )),
                            Expanded(
                                flex: 4,
                                child: Text(
                                  'Add Account'.tr(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  '${AppMeta.version} V',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          )),
    );
  }
}
