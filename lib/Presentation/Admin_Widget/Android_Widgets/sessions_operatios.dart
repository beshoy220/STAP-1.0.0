import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:school_manager/App/meta.dart';
import 'package:school_manager/Data/Firebase/real_time_db.dart';
import 'package:school_manager/Data/Local_providers/gades_classes.dart';
import 'package:school_manager/Data/Local_providers/list_of_week.dart';
import 'package:school_manager/Data/Local_providers/options_operations.dart';
import 'package:school_manager/Data/Local_providers/subject_dropdownlist.dart';
import 'package:school_manager/Presentation/Screens/admin_panal.dart';

///
///
///
///
///
/// View Grades
///
///
///
///
///
///

class SesssionViewGrades extends StatelessWidget {
  const SesssionViewGrades({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMeta.appName),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const AdminPanal()),
                    (Route<dynamic> route) => route is AdminPanal);
              },
              icon: const Icon(Icons.output))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: grades.length,
              itemBuilder: (BuildContext context, int index) {
                var grade = index + 1;
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: InkWell(
                    onTap: () {
                      NavigateTo(
                          context,
                          SesssionViewClasses(
                            grade: 'grade $grade',
                          ));
                    },
                    child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 109, 109, 109)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(18.0),
                                        child: Icon(
                                          Icons.bookmark,
                                          color: Colors.amber,
                                        ),
                                      ),
                                    ),
                                  )),
                              Expanded(
                                  flex: 6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          grades[index].toString().tr(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${'Contains'.tr()} ${classes.length} ${'classes'.tr()}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ))
                            ]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

///
///
///
///
///
/// View classes
///
///
///
///
///

class SesssionViewClasses extends StatelessWidget {
  SesssionViewClasses({Key? key, required this.grade}) : super(key: key);
  String grade;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMeta.appName),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const AdminPanal()),
                    (Route<dynamic> route) => route is AdminPanal);
              },
              icon: const Icon(Icons.output))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: classes.length,
              itemBuilder: (BuildContext context, int index) {
                var classs = index + 1;
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: InkWell(
                    onTap: () {
                      NavigateTo(
                          context,
                          TableLayOut(
                            grade: grade,
                            classs: 'class $classs',
                          ));
                    },
                    child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 109, 109, 109)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(18.0),
                                          child: Icon(
                                            Icons.bookmark,
                                            color: Colors.amber,
                                          ),
                                        ),
                                      ),
                                    )),
                                Expanded(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            classes[index].toString().tr(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Contains students'.tr(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ))
                              ]),
                        ]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
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
  String classs;
  String grade;

  TableLayOut({Key? key, required this.grade, required this.classs})
      : super(key: key);

  @override
  State<TableLayOut> createState() => _TableLayOutState();
}

class _TableLayOutState extends State<TableLayOut> {
  List edit = [false, false, false, false, false];
  List forms = [];
  int indexOfTable = 0;
  late String subject;
  List<String> teachers = ['--'];
  @override
  void initState() {
    super.initState();
    Database().ref.child('/teacher_acc').once().then((event) {
      (event.snapshot.value as Map).forEach((key, value) {
        String currentSubject = key;
        (value['users'] as Map).forEach((key, value) {
          setState(() {
            teachers.add("$currentSubject: ${value['name']}_$key");
          });
        });
      });
    });
  }

  addForm() {
    if (forms.isEmpty) {
      forms.addAll(
        [
          [
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            }
          ],
          [
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            }
          ],
          [
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            }
          ],
          [
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            }
          ],
          [
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            },
            {
              'sessions': subjectForDropdownlist.first,
              'teacher': teachers.first
            }
          ],
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(teachers);

    return Scaffold(
        appBar: AppBar(
          title: Text(AppMeta.appName),
          actions: [
            IconButton(
                onPressed: () {
                  Database().intiateSessions(widget.grade, widget.classs);
                },
                icon: const Icon(Icons.restart_alt)),
            IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const AdminPanal()),
                      (Route<dynamic> route) => route is AdminPanal);
                },
                icon: const Icon(Icons.output)),
          ],
        ),
        body: Stack(
          children: [
            // const Text('Refresh page to intiate data'),
            FirebaseAnimatedList(
              physics: const BouncingScrollPhysics(),
              defaultChild: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Refreshing..')
                ],
              )),
              query: Database().getSessions(widget.grade, widget.classs),
              itemBuilder: (context, snapshot, animation, index) {
                Map mappingValues = snapshot.value as Map;
                // print(mappingValues);
                return Column(children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        edit[index] ? edit[index] = false : edit[index] = true;
                        indexOfTable = index;
                      });
                      addForm();
                      // print(forms[index]);
                      edit[index]
                          ? ''
                          : Database().updateTableOfSessionsByDay(widget.grade,
                              widget.classs, 'day${index + 1}', forms[index]);
                    },
                    child: Container(
                        color: const Color.fromARGB(255, 11, 34, 137),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                daysOfWeek[index].toString().tr(),
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Icon(
                                edit[index] ? Icons.save : Icons.edit,
                                color: Colors.white,
                              )
                            ],
                          ),
                        )),
                  ),
                  SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  child: Text(
                                    'Session'.tr(),
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  )),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  child: Text('Subject'.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge)),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  child: Text('Teacher'.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge)),
                            ],
                          ),
                          (edit[index])
                              ? SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 1.4,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          mappingValues['sessions'].length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.3,
                                                child: Text(
                                                  (index + 1).toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                )),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.3,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: DropdownButton<String>(
                                                  value: forms[indexOfTable]
                                                      [index]['sessions'],
                                                  icon: const Icon(
                                                      Icons.arrow_downward),
                                                  elevation: 16,
                                                  isExpanded: true,
                                                  style: const TextStyle(
                                                      color: Colors.blue),
                                                  underline: Container(
                                                    height: 2,
                                                    color: Colors.blue,
                                                  ),
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      forms[indexOfTable][index]
                                                          ['sessions'] = value!;
                                                      subject =
                                                          value.toLowerCase();
                                                    });
                                                  },
                                                  items: subjectForDropdownlist
                                                      .map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                          (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value.tr()),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.3,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: DropdownButton<String>(
                                                    value: forms[indexOfTable]
                                                        [index]['teacher'],
                                                    icon: const Icon(
                                                        Icons.arrow_downward),
                                                    elevation: 16,
                                                    isExpanded: true,
                                                    style: const TextStyle(
                                                        color: Colors.blue),
                                                    underline: Container(
                                                      height: 2,
                                                      color: Colors.blue,
                                                    ),
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        forms[indexOfTable]
                                                                    [index]
                                                                ['teacher'] =
                                                            value!;
                                                      });
                                                    },
                                                    items: teachers.map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(
                                                            ('${value.toString().split(': ').first} : ${value.toString().split(': ').last.split('_').first}')),
                                                      );
                                                    }).toList(),
                                                  ),
                                                )),
                                            const Divider()
                                          ],
                                        );
                                      }),
                                )
                              : SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 1.5,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          mappingValues['sessions'].length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.3,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      14.0),
                                                  child: Text(
                                                    (index + 1).toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium,
                                                  ),
                                                )),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.3,
                                                child: Text(
                                                  mappingValues['sessions']
                                                          [index]
                                                      .toString()
                                                      .split('_')
                                                      .first
                                                      .tr(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                )),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.3,
                                                child: Text(
                                                  mappingValues['sessions']
                                                          [index]
                                                      .toString()
                                                      .split('_')
                                                      .last,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                )),
                                            const Divider()
                                          ],
                                        );
                                      }),
                                )
                        ],
                      )),
                ]);
              },
            )
          ],
        ));
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
