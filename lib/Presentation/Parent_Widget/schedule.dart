import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:school_manager/App/meta.dart';
import 'package:school_manager/Data/Firebase/authentication.dart';
import 'package:school_manager/Data/Firebase/real_time_db.dart';
import 'package:school_manager/Data/Local_providers/list_of_week.dart';
import 'package:expandable/expandable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  late String grade;
  late String classs;
  String email = Auth().currentUser!.email!.split('@').first;
  @override
  void initState() {
    super.initState();
    Database().ref.child('parent_feed/$email/sessions').onValue.listen((event) {
      Map mapping = event.snapshot.value as Map;
      setState(() {
        grade = mapping['grade'].toString();
        classs = mapping['class'].toString();
      });
    }).onError((e) {
      setState(() {
        grade = '';
        classs = '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: daysOfWeek.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpandableNotifier(
                    child: Column(
                      children: [
                        Expandable(
                          collapsed: ExpandableButton(
                            child: Column(
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  // height: double.maxFinite,
                                  height: 100,
                                  color: const Color.fromARGB(255, 9, 0, 104),
                                  child: Center(
                                    child: Text(
                                        daysOfWeek[index]
                                            .toString()
                                            .tr()
                                            .toString(),
                                        style: GoogleFonts.playfairDisplay(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          fontSize: 30,
                                          color: Colors.white,
                                          // fontWeight: FontWeight.w700,
                                          // fontStyle: FontStyle.italic,
                                        )),
                                  ),
                                ),
                                Container(
                                  width: double.maxFinite,
                                  height: 40,
                                  decoration:
                                      BoxDecoration(color: AppMeta.color),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Open'.tr(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          expanded: Column(children: [
                            // Text(daysOfWeek[index]),
                            TableLayOut(
                              day: daysOfWeek[index],
                              tableIndex: index,
                            ),
                            ExpandableButton(
                              child: Container(
                                  width: double.maxFinite,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(
                                    "Close".tr(),
                                    style: const TextStyle(color: Colors.white),
                                  ))),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ));
            },
          ),
          FutureBuilder(
            // initialData: {},
            future: Database().getQuitRequest(email),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data.snapshot.value == null) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [],
                  ),
                );
              } else {
                Map x = snapshot.data.snapshot.value as Map;

                return Center(
                    child: x['accepted']
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              color: const Color.fromARGB(165, 250, 17, 0),
                              child: Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Your student wants to quit the schedule'
                                          .tr(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      '${'Note'.tr()}:${x['reason']}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // OutlinedButton(
                                        //     onPressed: () {
                                        //       Database()
                                        //           .ref
                                        //           .child(
                                        //               '/parent_feed/$email/sessions/quit_request/accepted')
                                        //           .set(true);
                                        //     },
                                        //     child: const Text(
                                        //       'Allow',
                                        //       style: TextStyle(
                                        //           color: Colors.white),
                                        //     )),
                                        OutlinedButton(
                                            onPressed: () {
                                              Database()
                                                  .ref
                                                  .child(
                                                      '/parent_feed/$email/sessions/quit_request/accepted')
                                                  .set(true);
                                            },
                                            child: Text(
                                              'Okay'.tr(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ));
              }
            },
          ),
        ],
      ),
    );
  }
}

///
///
///
///
///
///
/// TableLayOut
///
///
///
///
///
///

class TableLayOut extends StatefulWidget {
  String day;
  int tableIndex;

  TableLayOut({Key? key, required this.day, required this.tableIndex})
      : super(key: key);

  @override
  State<TableLayOut> createState() => _TableLayOutState();
}

class _TableLayOutState extends State<TableLayOut> {
  // late String grade;
  // late String classs;
  String email = Auth().currentUser!.email!.split('@').first;
  // @override
  // void initState() {
  //   super.initState();
  //   Database().ref.child('parent_feed/$email/sessions').onValue.listen((event) {
  //     Map mapping = event.snapshot.value as Map;
  //     setState(() {
  //       grade = mapping['grade'].toString();
  //       classs = mapping['class'].toString();
  //     });
  //   }).onError((e) {
  //     setState(() {
  //       grade = '';
  //       classs = '';
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          Center(
              child: Text(
            widget.day.tr().toString(),
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )),
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3.2,
                    child: Center(
                        child: Text(
                      'Session'.tr().toString(),
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3.2,
                    child: Center(
                        child: Text('Subject'.tr().toString(),
                            style: Theme.of(context).textTheme.titleLarge)),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3.2,
                    child: Center(
                        child: Text('Teacher'.tr().toString(),
                            style: Theme.of(context).textTheme.titleLarge)),
                  ),
                ],
              ),
              const Divider()
            ],
          ),
          FirebaseAnimatedList(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            defaultChild: Center(
              child: Column(
                children: const [
                  SizedBox(height: 30),
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Loading...'),
                  SizedBox(height: 30),
                ],
              ),
            ),
            query: Database().getSessionsForParent(email, widget.tableIndex),
            itemBuilder: (context, snapshot, animation, index) {
              return Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3.2,
                        child: Center(
                            child: Text(
                          (index + 1).toString(),
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3.2,
                        child: Center(
                            child: Text(
                                snapshot.value.toString().split('_').first.tr(),
                                style:
                                    Theme.of(context).textTheme.titleMedium)),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3.2,
                        child: Center(
                            child: Text(
                                snapshot.value.toString().split('_').last,
                                style:
                                    Theme.of(context).textTheme.titleMedium)),
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              );
            },
          ),
        ]);
  }
}
