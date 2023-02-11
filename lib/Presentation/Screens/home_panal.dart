import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_manager/App/meta.dart';
import 'package:school_manager/Data/Firebase/authentication.dart';
import 'package:school_manager/Data/Firebase/messaging.dart';
import 'package:school_manager/Data/Local_providers/options_operations.dart';
import 'package:school_manager/Presentation/Screens/change_password.dart';
import 'package:school_manager/Services/Refresh/refresh.dart';
import 'package:school_manager/Services/Theme/theme.dart';
import 'package:school_manager/Presentation/Screens/account_manager.dart';
import 'package:school_manager/Presentation/Screens/report_error.dart';
import 'package:school_manager/Presentation/Parent_Widget/absence.dart';
import 'package:school_manager/Presentation/Parent_Widget/evaluation.dart';
import 'package:school_manager/Presentation/Parent_Widget/community.dart';
import 'package:school_manager/Presentation/Parent_Widget/schedule.dart';
import 'package:school_manager/Services/is_first_time_parent/isFirstTime.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../Data/Firebase/real_time_db.dart';

class ParentPanel extends StatefulWidget {
  const ParentPanel({Key? key}) : super(key: key);

  @override
  State<ParentPanel> createState() => _ParentPanelState();
}

class _ParentPanelState extends State<ParentPanel> {
  late TutorialCoachMark tutorialCoachMark;
  GlobalKey keyButton_1 = GlobalKey();
  GlobalKey keyButton_2 = GlobalKey();
  GlobalKey keyButton_3 = GlobalKey();
  GlobalKey keyButton_4 = GlobalKey();
  GlobalKey keyButton_5 = GlobalKey();

  @override
  void initState() {
    createTutorial();
    Database().saveTokenParent(Auth().currentUser!.email!.split('@').first);

    getIsFirstTimeToTrue().then((value) {
      if (value) {
        Future.delayed(Duration.zero, showTutorial);
        setIsFirstTimeToFalse();
      } else {
        debugPrint(
            'The user was here before and getIsFirstTimeToTrue() value is :$value');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Consumer(
            builder: (BuildContext context, ThemeModel themeNotifier, child) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                PopupMenuButton(
                    onSelected: (value) {
                      switch (value) {
                        case 1:
                          ThemeModel().refresh;
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ChangePassword()),
                          );

                          break;
                        case 5:
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
                    key: keyButton_5,
                    itemBuilder: (context) => [
                          PopupMenuItem(
                              value: 1,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.language,
                                    color: AppMeta.color,
                                  ),
                                  Text('Language'.tr().toString()),
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
                                  Text('Report error'.tr().toString()),
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
                                  Text('Dark Mode'.tr().toString()),
                                ],
                              )),
                          PopupMenuItem(
                              value: 4,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.password,
                                    color: AppMeta.color,
                                  ),
                                  Text('Change Password'.tr().toString()),
                                ],
                              )),
                          PopupMenuItem(
                              value: 5,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.account_circle_outlined,
                                    color: AppMeta.color,
                                  ),
                                  Text('Switch Account'.tr().toString()),
                                ],
                              )),
                        ]),
              ],
              bottom: TabBar(
                tabs: [
                  Tab(
                    key: keyButton_1,
                    icon: const Icon(Icons.schedule),
                    text: 'Schedule'.tr().toString(),
                  ),
                  Tab(
                    key: keyButton_2,
                    icon: const Icon(Icons.analytics_sharp),
                    text: 'Presence'.tr().toString(),
                  ),
                  Tab(
                    key: keyButton_3,
                    icon: const Icon(Icons.mode_comment_outlined),
                    text: 'Community'.tr().toString(),
                  ),
                  Tab(
                    key: keyButton_4,
                    icon: const Icon(Icons.featured_play_list_outlined),
                    text: 'Evaluation'.tr().toString(),
                  ),
                ],
              ),
              title: Text(
                AppMeta.appName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: ChangeNotifierProvider(
              create: (_) => Change(),
              child: Consumer(
                builder: (BuildContext context, Change change, Widget? child) {
                  return const TabBarView(
                    children: [
                      Schedule(),
                      Absence(),
                      Community(),
                      Evaluation()
                    ],
                  );
                },
              ),
            ),
          );
        }));
  }

  void showTutorial() {
    tutorialCoachMark.show(context: context);
  }

  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: Colors.black,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        print("finish");
      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        print("target: $target");
        print(
            "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
      onSkip: () {
        print("skip");
      },
    );
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];

    targets.add(TargetFocus(
      identify: "Target 1",
      keyTarget: keyButton_1,
      contents: [
        TargetContent(
            align: ContentAlign.bottom,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Schedule Tab",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0),
                    ),
                  ),
                  const Text(
                    "The schedule is just the place where you can see the time table of your child and you will be notified if the school changed it ",
                    style: TextStyle(
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "خانت الجدول",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0),
                    ),
                  ),
                  const Text(
                    "هنا سوف تجد كل ما يخص الجداول حيث ان الجدول هو المكان الذي يمكنك فيه رؤية جدول الحصص لطفلك وسيتم إعلامك إذا غيرته المدرسة",
                    style: TextStyle(
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        tutorialCoachMark.next();
                      },
                      child: const Text(
                        'NEXT',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ))
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));

    targets.add(TargetFocus(
      identify: "Target 2",
      keyTarget: keyButton_2,
      contents: [
        TargetContent(
            align: ContentAlign.bottom,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Prsences & Absence",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0),
                    ),
                  ),
                  const Text(
                    "Here you can track all presences and absences of your child session by session from the first day to the last one in the semester",
                    style: TextStyle(
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "الغياب و الحضور",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0),
                    ),
                  ),
                  const Text(
                    "هنا يمكنك تتبع جميع حالات التواجد والغياب لطفلك حصه بحصه من اليوم الأول إلى اليوم الأخير في الفصل الدراسي",
                    style: TextStyle(
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        tutorialCoachMark.next();
                      },
                      child: const Text(
                        'NEXT',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ))
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));

    targets.add(TargetFocus(
      identify: "Target 3",
      keyTarget: keyButton_3,
      contents: [
        TargetContent(
            align: ContentAlign.bottom,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Community",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0),
                    ),
                  ),
                  const Text(
                    "Here you will receive votes and two types of messages : A private message that you only receive & A public message that all class or school receive",
                    style: TextStyle(
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "المجتمع",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0),
                    ),
                  ),
                  const Text(
                    "ستتلقى هنا أصواتًا ونوعين من الرسائل: رسالة خاصة تتلقاها انت فقط و رسالة عامة يتلقاها كل الفصل أو المدرسة",
                    style: TextStyle(
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        tutorialCoachMark.next();
                      },
                      child: const Text(
                        'NEXT',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ))
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));

    targets.add(TargetFocus(
      identify: "Target 4",
      keyTarget: keyButton_4,
      contents: [
        TargetContent(
            align: ContentAlign.bottom,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Evaluation",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0),
                    ),
                  ),
                  const Text(
                    "All Marks of all subjects will be listed here as: final, mid-term or just a quiz",
                    style: TextStyle(
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "التقيم",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0),
                    ),
                  ),
                  const Text(
                    "جميع علامات المواد ستكون هنا مثل: الفاينال و الميد تيرم و الامنحنات الصغيره",
                    style: TextStyle(
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        tutorialCoachMark.next();
                      },
                      child: const Text(
                        'NEXT',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ))
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));

    targets.add(TargetFocus(
      identify: "Target 5",
      keyTarget: keyButton_5,
      contents: [
        TargetContent(
            align: ContentAlign.bottom,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "More feature !",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0),
                    ),
                  ),
                  const Text(
                    "Here you can get more features like changing language, report an error, dark mode, change password and switching account ! ",
                    style: TextStyle(
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "ميزات اخرى",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0),
                    ),
                  ),
                  const Text(
                    "هنا يمكنك الحصول على المزيد من الميزات مثل تغيير اللغة والإبلاغ عن مشكله والوضع الليلى و تغير كلمه السر و تغير الحساب",
                    style: TextStyle(
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        tutorialCoachMark.next();
                      },
                      child: const Text(
                        'NEXT',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ))
                ],
              ),
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));
    return targets;
  }
}
