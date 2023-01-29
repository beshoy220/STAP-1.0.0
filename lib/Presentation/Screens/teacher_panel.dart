import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_manager/App/meta.dart';
import 'package:school_manager/Data/Firebase/authentication.dart';
import 'package:school_manager/Data/Firebase/real_time_db.dart';
import 'package:school_manager/Data/Local_providers/options_operations.dart';
import 'package:school_manager/Presentation/Screens/change_password.dart';
import 'package:school_manager/Services/Theme/theme.dart';
import 'package:school_manager/Presentation/Screens/account_manager.dart';
import 'package:school_manager/Presentation/Screens/report_error.dart';

class TeacherPanal extends StatefulWidget {
  const TeacherPanal({super.key});

  @override
  State<TeacherPanal> createState() => _TeacherPanalState();
}

class _TeacherPanalState extends State<TeacherPanal> {
  final Tween<double> _scaleTween = Tween<double>(begin: 1, end: 0);
  double scaleee = 1;

  String subject = '';
  String email = Auth().currentUser!.email!.split('@').first;

  String name = '';
  String gender = '';

  // late String prof = (gender == 'male') ? 'Mr' : 'Mrs';

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        scaleee = 0;
      });
      Database()
          .ref
          .child('/teacher_acc/$subject/users/$email')
          .onValue
          .listen((event) {
        Map mapping = event.snapshot.value as Map;
        setState(() {
          name = mapping['name'].toString().split(' ').first;
          gender = mapping['gender'].toString();
        });
      });
    });
    Database().ref.child('teacher_feed/$email').onValue.listen((event) {
      Map mapping = event.snapshot.value as Map;
      setState(() {
        subject = mapping['subject'].toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return FutureBuilder(
          initialData: false,
          future: ThemeModel().themeFromSharedPref(),
          builder:
              (BuildContext context, AsyncSnapshot snapshot) =>
                  Stack(children: [
                    Scaffold(
                      appBar: AppBar(
                        // automaticallyImplyLeading: false,

                        backgroundColor: snapshot.data
                            ? const Color.fromARGB(255, 36, 36, 36)
                            : AppMeta.color,
                        actions: [
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet<void>(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    isDismissible: false,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SingleChildScrollView(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          child: Column(
                                            children: [
                                              Center(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child: Text(
                                                  'Notifications'.tr(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                ),
                                              )),
                                              FirebaseAnimatedList(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                query: Database()
                                                    .getTeacherMessages(
                                                        subject, email),
                                                itemBuilder: (context, snapshot,
                                                    animation, index) {
                                                  Map mappingValues =
                                                      snapshot.value as Map;
                                                  // print(snapshot.value);
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            18.0),
                                                    child: Container(
                                                      width: double.maxFinite,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              134, 148, 227)),
                                                      child: Row(children: [
                                                        Expanded(
                                                            flex: 2,
                                                            child: Center(
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          18.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .mode_comment_outlined,
                                                                    color: mappingValues['status'] ==
                                                                            'very_urgent'
                                                                        ? Colors
                                                                            .red
                                                                        : mappingValues['status'] ==
                                                                                'semi_urgent'
                                                                            ? Colors.yellow
                                                                            : Colors.green,
                                                                  ),
                                                                ),
                                                              ),
                                                            )),
                                                        Expanded(
                                                            flex: 6,
                                                            child: Center(
                                                              child: Stack(
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(vertical: 8.0),
                                                                          child:
                                                                              Text(
                                                                            mappingValues['title'],
                                                                            style: const TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              bottom: 18.0,
                                                                              right: 8.0,
                                                                              left: 5.0),
                                                                          child:
                                                                              Text(
                                                                            mappingValues['body'],
                                                                            style:
                                                                                const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              bottom: 18.0,
                                                                              right: 8.0,
                                                                              left: 5.0),
                                                                          child:
                                                                              Text(
                                                                            // ignore: prefer_interpolation_to_compose_strings
                                                                            'From'.tr() +
                                                                                ' : ' +
                                                                                mappingValues['from'] +
                                                                                '\n' +
                                                                                'Date'.tr() +
                                                                                ' : ' +
                                                                                mappingValues['date'],
                                                                            style:
                                                                                Theme.of(context).textTheme.caption,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Align(
                                                                        alignment: (context.locale ==
                                                                                const Locale('en', 'US'))
                                                                            ? Alignment.centerRight
                                                                            : Alignment.centerLeft,
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: mappingValues['status'] == 'very_urgent'
                                                                                  ? Colors.red
                                                                                  : mappingValues['status'] == 'semi_urgent'
                                                                                      ? Colors.yellow
                                                                                      : Colors.green,
                                                                              borderRadius: BorderRadius.circular(1000)),
                                                                          width:
                                                                              12,
                                                                          height:
                                                                              12,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ]),
                                                            ))
                                                      ]),
                                                    ),
                                                  );
                                                },
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: ElevatedButton(
                                                    child: Text(
                                                        'Close BottomSheet'
                                                            .tr()),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              )
                                              // FirebaseAnimatedList(query: query, itemBuilder: itemBuilder)
                                            ],
                                          ));
                                    });
                              },
                              icon: const Icon(Icons.notifications)),
                          PopupMenuButton(
                              onSelected: (value) {
                                switch (value) {
                                  case 1:
                                    if (context.locale ==
                                        const Locale('en', 'US')) {
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
                                    break;
                                  case 4:
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ChangePassword()),
                                    );
                                    break;
                                  case 5:
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AccountMaanger()),
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
                                        )),
                                    PopupMenuItem(
                                        value: 4,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.password,
                                              color: AppMeta.color,
                                            ),
                                            Text('Change Password'
                                                .tr()
                                                .toString()),
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
                                            Text('Switch Account'.tr()),
                                          ],
                                        )),
                                  ]),
                        ],
                        elevation: 0,
                        title: Text(
                          AppMeta.appName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      body: Consumer(
                          builder: (context, ThemeModel themeNotifier, child) {
                        return Stack(children: [
                          Container(
                            height: MediaQuery.of(context).size.height,
                            width: double.maxFinite,
                            color: snapshot.data
                                ? const Color.fromARGB(255, 36, 36, 36)
                                : AppMeta.color,
                          ),
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Container(
                              color: snapshot.data
                                  ? const Color.fromARGB(255, 4, 0, 17)
                                  : Colors.white,
                              child: Column(
                                children: [
                                  Container(
                                    width: double.maxFinite,
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    decoration: BoxDecoration(
                                        color: snapshot.data
                                            ? const Color.fromARGB(
                                                255, 36, 36, 36)
                                            : AppMeta.color,
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        )),
                                    child: Center(
                                      child: Text(
                                        '${'Welcome'.tr()} $name',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: teacherHomeNav.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: InkWell(
                                              onTap: () {
                                                NavigateTo(context,
                                                    teacherHomeNav[index][4]);
                                              },
                                              child: Stack(children: [
                                                Container(
                                                  height: 200.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          teacherHomeNav[index]
                                                              [3]),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 200.0,
                                                  width: double.maxFinite,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        141, 0, 0, 0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              teacherHomeNav[
                                                                  index][0],
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            Text(
                                                              teacherHomeNav[
                                                                      index][1]
                                                                  .toString()
                                                                  .tr(),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          teacherHomeNav[index]
                                                                  [2]
                                                              .toString()
                                                              .tr(),
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Colors.white70,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                            ));
                                      },
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Text(
                                        'V ${AppMeta.version}',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ]);
                      }),
                    ),
                    TweenAnimationBuilder(
                      duration: const Duration(seconds: 3),
                      tween: _scaleTween,
                      builder: (context, scale, child) {
                        return Transform.scale(
                          scale: scaleee,
                          child: child,
                        );
                      },
                      child: Scaffold(
                        backgroundColor: snapshot.data
                            ? const Color.fromARGB(255, 36, 36, 36)
                            : AppMeta.color,
                        body: SafeArea(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text(
                                    ' Welcome... \n\nSetting the enviroment and tools for you'
                                        .tr(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                                const SizedBox(
                                  height: 200,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(18.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]));
    });
  }
}
