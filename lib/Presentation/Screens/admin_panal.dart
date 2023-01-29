import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_manager/App/meta.dart';
import 'package:school_manager/Data/Firebase/authentication.dart';
import 'package:school_manager/Data/Local_providers/options_operations.dart';
import 'package:school_manager/Services/Theme/theme.dart';
import 'package:school_manager/Presentation/Screens/account_manager.dart';
import 'package:school_manager/Presentation/Screens/report_error.dart';
import 'package:school_manager/Presentation/Admin_Widget/Windows_Widgets/operations.dart';
import 'package:easy_localization/easy_localization.dart';

class AdminPanal extends StatelessWidget {
  const AdminPanal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isWindows = Platform.isWindows;

    return isWindows ? const DesktopView() : const MobileViewOperations();
  }
}

class DesktopView extends StatefulWidget {
  const DesktopView({super.key});

  @override
  _DesktopViewState createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
  var selectedIndex = 0;

  List operations = [
    Operations(
      source: studentOperations,
      operationsOf: 'student',
    ),
    Operations(
      source: teacherOperations,
      operationsOf: 'teacher',
    ),
    Operations(
      source: sessionOperations,
      operationsOf: 'sessions',
    ),
    Operations(
      source: messageOperations,
      operationsOf: 'message',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(AppMeta.appName),
            ),
          ),
        ),
        body: Row(
          children: [
            Expanded(
                flex: 1,
                child: Center(
                  child: Container(
                    color: Colors.black54,
                    child: ListView.builder(
                      itemCount: adminOptionsForWindows.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: ListTile(
                            leading: Icon(
                              adminOptionsForWindows[index][1],
                              size: 25,
                              color: Colors.white,
                            ),
                            title: Text(
                              adminOptionsForWindows[index][0],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )),
            Expanded(
              flex: currentWidth < 1000 ? 2 : 5,
              child: operations.elementAt(selectedIndex),
            )
          ],
        ));
  }
}

class MobileViewOperations extends StatelessWidget {
  const MobileViewOperations({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('${AppMeta.appName} ${'(ADMIN)'.tr()}'),
            actions: [
              PopupMenuButton(
                  onSelected: (value) async {
                    switch (value) {
                      case 1:
                        if (context.locale == const Locale('en', 'US')) {
                          // ignore: deprecated_member_use
                          context.locale = const Locale('ar', 'EG');
                        } else {
                          // ignore: deprecated_member_use
                          context.locale = const Locale('en', 'US');
                        }
                        break;
                      case 2:
                        NavigateTo(context, const ReportError());
                        break;
                      case 3:
                        themeNotifier.isDark
                            ? themeNotifier.changeTheme = false
                            : themeNotifier.changeTheme = true;
                        // switchTheme();
                        break;
                      case 4:
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AccountMaanger()),
                        );
                        Auth().signOut();
                        break;
                      default:
                    }
                  },
                  itemBuilder: (context) => [
                        PopupMenuItem(
                            value: 1,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.language,
                                  color: AppMeta.color,
                                ),
                                Text('Language'.tr()),
                              ],
                            )),
                        PopupMenuItem(
                            value: 2,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.bug_report,
                                  color: AppMeta.color,
                                ),
                                Text('Report error'.tr()),
                              ],
                            )),
                        PopupMenuItem(
                          value: 3,
                          child: Row(
                            children: [
                              Icon(
                                Icons.dark_mode,
                                color: AppMeta.color,
                              ),
                              Text('Dark Mode'.tr()),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 4,
                          child: Row(
                            children: [
                              Icon(
                                Icons.account_circle_outlined,
                                color: AppMeta.color,
                              ),
                              Text('Switch Account'.tr()),
                            ],
                          ),
                        ),
                      ]),
            ],
          ),
          body: FutureBuilder(
            future: ThemeModel().themeFromSharedPref(),
            initialData: false,
            builder: (BuildContext context, AsyncSnapshot snapshot) =>
                SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: adminOptionsForAndroid.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  NavigateTo(context,
                                      adminOptionsForAndroid[index][2]);

                                  break;
                                case 1:
                                  NavigateTo(context,
                                      adminOptionsForAndroid[index][2]);

                                  break;
                                case 2:
                                  NavigateTo(context,
                                      adminOptionsForAndroid[index][2]);

                                  break;
                                case 3:
                                  NavigateTo(context,
                                      adminOptionsForAndroid[index][2]);

                                  break;
                                case 4:
                                  NavigateTo(context,
                                      adminOptionsForAndroid[index][2]);

                                  break;
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: snapshot.data
                                      ? Colors.blueGrey
                                      : AppMeta.color,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      adminOptionsForAndroid[index][1],
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      adminOptionsForAndroid[index][0]
                                          .toString()
                                          .tr(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        })),
          ));
    });
  }
}
