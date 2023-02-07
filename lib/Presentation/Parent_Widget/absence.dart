import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:school_manager/Data/Firebase/authentication.dart';
import 'package:school_manager/Data/Firebase/real_time_db.dart';
import 'package:table_calendar/table_calendar.dart';

class Absence extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  const Absence({Key? key}) : super(key: key);

  @override
  AbsenceState createState() => AbsenceState();
}

class AbsenceState extends State<Absence> {
  // late String grade;
  // late String classs;
  CalendarFormat calender = CalendarFormat.twoWeeks;
  DateTime? _selectedDay = DateTime.now();
  DateTime? _focusedDay;
  String email = Auth().currentUser!.email!.split('@').first;
  int dayOfweek = 0;
  String? day;

  _sessions(String i, String session, String prof) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Color.fromARGB(
              255, Random().nextInt(60), Random().nextInt(60), 0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${'Session'.tr()} : ${int.parse(i) + 1}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${'Subject'.tr()} : ${session.tr()}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${'Teacher'.tr()} : $prof',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  FutureBuilder(
                    initialData: null,
                    future: Database()
                        .ref
                        .child('parent_feed/$email/presence/$day')
                        .once(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data.snapshot.value == null) {
                        return const Text('__');
                      } else if (snapshot.hasData &&
                          snapshot.data.snapshot.value != null) {
                        List listValues = snapshot.data.snapshot.value as List;
                        if (int.parse(i) < listValues.length) {
                          return (listValues[int.parse(i)])
                              ? Row(
                                  children: [
                                    Text(
                                      '${'Present'.tr()}  :  ',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      color: Colors.green,
                                      child: const Icon(
                                        Icons.check_box_outlined,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                )
                              : Row(
                                  children: [
                                    Text(
                                      '${'Absent'.tr()}  :  ',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      color: Colors.red,
                                      child: const Icon(
                                        Icons.disabled_by_default_outlined,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                );
                        } else {
                          return Row(
                            children: [
                              Text(
                                '${'Yet'.tr()}  :  ',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                color: Colors.amber,
                                child: const Icon(
                                  Icons.indeterminate_check_box_outlined,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          );
                        }
                      } else if (snapshot.hasError) {
                        return const Text('');
                      } else {
                        return const Text('');
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _holidays() {
    return Column(
      children: [
        const SizedBox(
          height: 90,
        ),
        const Icon(
          Icons.smart_button,
          size: 50,
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: [
            Text(
              'It seems that today is a holiday and no school today'.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 140,
            )
          ],
        ),
      ],
    );
  }

  timeCovert(format) {
    switch (format) {
      case CalendarFormat.month:
        setState(() {
          calender = CalendarFormat.month;
        });
        break;
      case CalendarFormat.twoWeeks:
        setState(() {
          calender = CalendarFormat.twoWeeks;
        });
        break;
      case CalendarFormat.week:
        setState(() {
          calender = CalendarFormat.week;
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(dayOfweek);
    return Scaffold(
        body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          TableCalendar(
            locale: (context.locale == const Locale('en', 'US'))
                ? 'en_US'
                : 'ar_EG',
            onFormatChanged: (format) {
              timeCovert(format);
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                switch (selectedDay.weekday) {
                  case 6:
                    dayOfweek = 1;
                    break;
                  case 1:
                    dayOfweek = 2;

                    break;
                  case 2:
                    dayOfweek = 3;
                    break;
                  case 3:
                    dayOfweek = 4;
                    break;
                  case 4:
                    dayOfweek = 5;
                    break;
                  default:
                }
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                day =
                    '${focusedDay.day}-${focusedDay.month}-${focusedDay.year}';
                // print(selectedDay.weekday);
              });
            },
            calendarFormat: calender,
            firstDay: DateTime.utc(2022, 12, 31),
            lastDay: DateTime.utc(2028, 12, 14),
            focusedDay: DateTime.now(),
          ),
          const Divider(),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.green,
                        child: const Icon(
                          Icons.check_box_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text('Present'.tr())
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.red,
                        child: const Icon(
                          Icons.disabled_by_default_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text('Absent'.tr())
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.amber,
                        child: const Icon(
                          Icons.indeterminate_check_box_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text('Yet'.tr())
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Today\'s Presence'.tr(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(2),
              child: _selectedDay!.weekday == 7 || _selectedDay!.weekday == 5
                  ? _holidays()
                  : dayOfweek != 0
                      ? FutureBuilder(
                          future: Database()
                              .ref
                              .child(
                                  '/parent_feed/$email/sessions/day$dayOfweek/sessions')
                              .once(),
                          builder: (context, AsyncSnapshot snapshot) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.snapshot.value.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ((snapshot.data.snapshot.value
                                                as List)[index]
                                            .toString()
                                            .split('_')
                                            .first ==
                                        'Break')
                                    ? Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          width: double.maxFinite,
                                          decoration: const BoxDecoration(
                                            color: Colors.indigo,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                                child: Text(
                                              'Break'.tr(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                        ))
                                    : _sessions(
                                        index.toString(),
                                        (snapshot.data.snapshot.value
                                                as List)[index]
                                            .toString()
                                            .split('_')
                                            .first,
                                        (snapshot.data.snapshot.value
                                                as List)[index]
                                            .toString()
                                            .split('_')
                                            .last);
                              },
                            );
                          },
                        )
                      : Column(
                          children: [
                            SizedBox(
                                height: MediaQuery.of(context).size.height / 8),
                            Text(
                              'Selecte Day'.tr(),
                              style: const TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ))
        ],
      ),
    ));
  }
}
