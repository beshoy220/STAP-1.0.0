import 'dart:io' show Platform;
import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_manager/App/meta.dart';
import 'package:school_manager/Data/Firebase/authentication.dart';
import 'package:school_manager/Presentation/Screens/admin_panal.dart';
import 'package:school_manager/Presentation/Screens/home_panal.dart';
import 'package:school_manager/Presentation/Screens/teacher_panel.dart';
import 'package:school_manager/Services/Theme/theme.dart';
import 'package:school_manager/Presentation/Admin_Widget/Windows_Widgets/welcome_page_windows.dart';
import 'Presentation/Screens/welcome_sign_in_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Data/Firebase/messaging.dart';

void main() async {
  // firebase initializeApp
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // cloud messaging
  foreground();
  background();

  // language initializer
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // error handler
  ErrorWidget.builder = (FlutterErrorDetails error) {
    debugPrint(error.exception.toString());
    return Container(
      alignment: Alignment.center,
      child: Text('Connecting..'.tr()),
    );
  };

  // Firebase initializer [for Database]
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  // root app
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/translate',
      saveLocale: true,
      fallbackLocale: const Locale('en', 'US'),
      child: MyApp()));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final isWindows = Platform.isWindows;
  var userType = Auth().currentUser?.email?.split('-').first.toString();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer(
        builder: (context, ThemeModel themeNotifier, child) {
          return FutureBuilder(
              future: ThemeModel().themeFromSharedPref(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MaterialApp(
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    debugShowCheckedModeBanner: false,
                    title: AppMeta.appName,
                    theme: ThemeData(
                      colorSchemeSeed: AppMeta.color,
                      brightness:
                          snapshot.data ? Brightness.dark : Brightness.light,
                    ),
                    home: isWindows
                        ? const WelcomePageWindow()
                        : StreamBuilder(
                            stream: Auth().authStateChanges,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (userType == 'pt') {
                                  return const ParentPanel();
                                } else if (userType == 'tc') {
                                  return const TeacherPanal();
                                } else if (userType == 'admin') {
                                  return const AdminPanal();
                                } else {
                                  return const WelcomeSingInMobile();
                                }
                              } else {
                                debugPrint(userType);
                                return const WelcomeSingInMobile();
                              }
                            },
                          ),
                  );
                } else {
                  return MaterialApp(
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    debugShowCheckedModeBanner: false,
                    title: AppMeta.appName,
                    theme: ThemeData(
                      colorSchemeSeed: AppMeta.color,
                      brightness: Brightness.light,
                    ),
                    home: isWindows
                        ? const WelcomePageWindow()
                        : StreamBuilder(
                            stream: Auth().authStateChanges,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (userType == 'pt') {
                                  return const ParentPanel();
                                } else if (userType == 'tc') {
                                  return const TeacherPanal();
                                } else if (userType == 'admin') {
                                  return const AdminPanal();
                                } else {
                                  return const WelcomeSingInMobile();
                                }
                              } else {
                                debugPrint(userType);
                                return const WelcomeSingInMobile();
                              }
                            },
                          ),
                  );
                }
              });
        },
      ),
    );
  }
}
