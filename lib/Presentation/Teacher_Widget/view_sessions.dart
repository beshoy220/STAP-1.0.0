import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:school_manager/App/meta.dart';
import 'package:school_manager/Data/Firebase/authentication.dart';
import 'package:school_manager/Data/Firebase/real_time_db.dart';
import 'package:school_manager/Data/Local_providers/list_of_week.dart';

class TeacherSessions extends StatefulWidget {
  const TeacherSessions({super.key});

  @override
  State<TeacherSessions> createState() => _TeacherSessionsState();
}

class _TeacherSessionsState extends State<TeacherSessions> {
  var today = DateFormat('EEEE').format(DateTime.now());
  Day(dayIndex) {
    return Column(
      children: [
        Text(
          today == daysOfWeek[dayIndex]
              ? daysOfWeek[dayIndex].toString().tr() + ' (Today)'.tr()
              : daysOfWeek[dayIndex].toString().tr(),
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: dayIndex.isEven ? AppMeta.color : Colors.blueGrey),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.3,
                child: Center(
                    child: Text(
                  'Session'.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                )),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.3,
                child: Center(
                    child: Text('class'.tr(),
                        style: Theme.of(context).textTheme.titleLarge)),
              ),
            ],
          ),
        ),
        const Divider(),
        FirebaseAnimatedList(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          query: Database().getSessionsForTeacher(),
          itemBuilder: (context, snapshot, animation, index) {
            String email = snapshot.value as String;
            String sessions = snapshot.key as String;
            if (email == Auth().currentUser!.email?.split("@").first) {
              if ((dayIndex + 1) ==
                  int.parse(sessions.split('_')[3].split('y').last)) {
                return Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: Center(
                              child: Text(
                            sessions.split('_')[0][1],
                            style: Theme.of(context).textTheme.titleLarge,
                          )),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: Center(
                              child: Text(
                                  '${sessions.split('_')[1].capitalize().tr()}  ${sessions.split('_')[2].capitalize().tr()}',
                                  style:
                                      Theme.of(context).textTheme.titleLarge)),
                        ),
                      ],
                    ),
                  ),
                  const Divider()
                ]);
              } else {
                return const Center();
              }
            } else {
              return const Center();
            }
          },
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMeta.appName),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [Day(0), Day(1), Day(2), Day(3), Day(4)],
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
