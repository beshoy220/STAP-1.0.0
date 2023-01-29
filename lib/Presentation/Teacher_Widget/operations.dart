import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:school_manager/App/meta.dart';
import 'package:school_manager/Data/Firebase/authentication.dart';
import 'package:school_manager/Data/Firebase/real_time_db.dart';
import 'package:school_manager/Data/Local_providers/gades_classes.dart';
import 'package:school_manager/Data/Local_providers/options_operations.dart';
import 'package:school_manager/Data/Local_providers/quiz_type.dart';
import 'package:school_manager/Presentation/Screens/teacher_panel.dart';

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

class ViewGradesForTeacher extends StatelessWidget {
  const ViewGradesForTeacher({Key? key, required this.opreationType})
      : super(key: key);
  final dynamic opreationType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.output_rounded))
        ],
        title: Text(AppMeta.appName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: grades.length,
              itemBuilder: (BuildContext context, int index) {
                Map map = <String, int>{
                  'operation': opreationType,
                  'grade': index
                };
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: InkWell(
                    onTap: () {
                      print(map);

                      NavigateTo(
                          context,
                          ViewClasses(
                            source: map,
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

class ViewClasses extends StatelessWidget {
  const ViewClasses({Key? key, required this.source}) : super(key: key);
  final Map source;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const TeacherPanal()),
                    (Route<dynamic> route) => route is TeacherPanal);
              },
              icon: const Icon(Icons.output_rounded))
        ],
        title: Text(AppMeta.appName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: classes.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, int> destiney = {
                  'operation': source['operation'],
                  'grade': source['grade'],
                  'class': index
                };
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: InkWell(
                    onTap: () {
                      print(destiney['operation']);
                      int? x = destiney['operation'];
                      print(destiney);
                      switch (x) {
                        case 0:
                          NavigateTo(
                              context,
                              PrivateMessage(
                                  grade: 'grade ${source['grade'] + 1}',
                                  classs: 'class ${index + 1}'));
                          break;
                        case 1:
                          NavigateTo(
                              context,
                              PresencesCheck(
                                  grade: 'grade ${source['grade'] + 1}',
                                  classs: 'class ${index + 1}'));
                          break;
                        case 2:
                          NavigateTo(
                              context,
                              Evaluaion(
                                  grade: 'grade ${source['grade'] + 1}',
                                  classs: 'class ${index + 1}'));
                          break;
                        case 3:
                          NavigateTo(
                              context,
                              Permissions(
                                  grade: 'grade ${source['grade'] + 1}',
                                  classs: 'class ${index + 1}'));
                          break;
                      }
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
/// ADD PRiVATTE MESSAGE FOR DB
///
/// ADD PRiVATTE MESSAGE FOR DB
///
/// ADD PRiVATTE MESSAGE FOR DB
///
///
///
///
///
///
///
///
/// ADD PRiVATTE MESSAGE FOR DB
///
/// ADD PRiVATTE MESSAGE FOR DB
///
/// ADD PRiVATTE MESSAGE FOR DB
///
///
///
///
///
///
///
///
/// ADD PRiVATTE MESSAGE FOR DB
///
/// ADD PRiVATTE MESSAGE FOR DB
///
/// ADD PRiVATTE MESSAGE FOR DB
///
///
///
///

class PrivateMessage extends StatefulWidget {
  String grade;
  String classs;

  PrivateMessage({Key? key, required this.grade, required this.classs})
      : super(key: key);
  @override
  State<PrivateMessage> createState() => _PrivateMessageState();
}

class _PrivateMessageState extends State<PrivateMessage> {
  bool selectAll = false;
  List<bool> checkBoxs = [];
  List<String> listOfMessageTo = [];

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
                        builder: (BuildContext context) =>
                            const TeacherPanal()),
                    (Route<dynamic> route) => route is TeacherPanal);
              },
              icon: const Icon(Icons.output))
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: Text('Parent name'.tr())),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('select all'.tr()),
                              Checkbox(
                                  value: selectAll,
                                  onChanged: (value) {
                                    setState(() {
                                      selectAll = value!;
                                    });
                                  })
                            ],
                          )),
                    ],
                  ),
                  const Divider(),
                  FirebaseAnimatedList(
                    defaultChild: Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          const CircularProgressIndicator(),
                          const SizedBox(height: 20),
                          Text('Loading...'.tr()),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    query:
                        Database().getUsersOfClass(widget.grade, widget.classs),
                    itemBuilder: (context, snapshot, animation, index) {
                      Map mappingValue = snapshot.value as Map;

                      if (checkBoxs.length == index) {
                        checkBoxs.add(true);
                      }

                      if (listOfMessageTo.length == index) {
                        listOfMessageTo.add(snapshot.key.toString());
                        // print('messages : ${listOfMessageTo.length} --- index : $index');
                      }

                      return Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2.2,
                              child:
                                  Text(mappingValue['parent_name'].toString())),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: selectAll
                                  ? Align(
                                      alignment: Alignment.center,
                                      child: Checkbox(
                                          value: checkBoxs[index],
                                          onChanged: (value) {
                                            setState(() {
                                              checkBoxs[index] = value!;
                                              if (checkBoxs[index] == false) {
                                                listOfMessageTo.removeAt(index);
                                                listOfMessageTo.insert(
                                                    index, 'null');
                                              } else {
                                                listOfMessageTo.removeAt(index);
                                                listOfMessageTo.insert(index,
                                                    snapshot.key.toString());
                                              }
                                            });
                                          }),
                                    )
                                  : OutlinedButton(
                                      onPressed: () {
                                        NavigateTo(
                                            context,
                                            PrivateMessageForm(
                                                grade: widget.grade,
                                                classs: widget.classs,
                                                messageTo: [
                                                  snapshot.key.toString()
                                                ]));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Send !'.tr()),
                                          const Icon(Icons.arrow_right_rounded)
                                        ],
                                      ))),
                          const Divider(),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            selectAll
                ? Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: OutlinedButton(
                          onPressed: () {
                            NavigateTo(
                                context,
                                PrivateMessageForm(
                                  grade: widget.grade,
                                  classs: widget.classs,
                                  messageTo: listOfMessageTo,
                                ));

                            // debugPrint(listOfMessageTo.toString());
                          },
                          child: Text('Message'.tr())),
                    ),
                  )
                : const SizedBox(
                    height: 10,
                  ),
          ],
        ),
      ),
    );
  }
}

class PrivateMessageForm extends StatefulWidget {
  List<String> messageTo;
  String grade;
  String classs;
  PrivateMessageForm(
      {super.key,
      required this.messageTo,
      required this.grade,
      required this.classs});

  @override
  State<PrivateMessageForm> createState() => _PrivateMessageFormState();
}

class _PrivateMessageFormState extends State<PrivateMessageForm> {
  String finalStatus = '';
  MaterialColor nUrget = Colors.green;
  MaterialColor sUrget = Colors.amber;
  MaterialColor vUrget = Colors.red;

  bool selectVeryUrget = false;
  bool selectSemiUrget = false;
  bool selectNotUrget = false;

  final TextEditingController _controllerForMessageTitle =
      TextEditingController();
  final TextEditingController _controllerForMessageBody =
      TextEditingController();

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
                        builder: (BuildContext context) =>
                            const TeacherPanal()),
                    (Route<dynamic> route) => route is TeacherPanal);
              },
              icon: const Icon(Icons.output))
        ],
      ),
      body: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputChip(
                      selected: selectNotUrget,
                      onPressed: () {
                        if (selectSemiUrget == true ||
                            selectVeryUrget == true) {
                        } else {
                          setState(() {
                            switch (selectNotUrget) {
                              case false:
                                selectNotUrget = true;
                                finalStatus = 'not_urgent';
                                break;
                              case true:
                                selectNotUrget = false;
                                finalStatus = '';
                                break;
                            }
                          });
                        }
                      },
                      labelPadding: const EdgeInsets.all(2.0),
                      label: Text(
                        'Not-Urgent'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: nUrget,
                      elevation: 6.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputChip(
                      selected: selectSemiUrget,
                      onPressed: () {
                        if (selectNotUrget == true || selectVeryUrget == true) {
                        } else {
                          setState(() {
                            switch (selectSemiUrget) {
                              case false:
                                selectSemiUrget = true;
                                finalStatus = 'semi_urgent';

                                break;
                              case true:
                                selectSemiUrget = false;
                                finalStatus = '';

                                break;
                            }
                          });
                        }
                      },
                      labelPadding: const EdgeInsets.all(2.0),
                      label: Text(
                        'Semi-Urgent'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: sUrget,
                      elevation: 6.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputChip(
                      selected: selectVeryUrget,
                      onPressed: () {
                        if (selectNotUrget == true || selectSemiUrget == true) {
                        } else {
                          setState(() {
                            switch (selectVeryUrget) {
                              case false:
                                selectVeryUrget = true;
                                finalStatus = 'very_urgent';

                                break;
                              case true:
                                selectVeryUrget = false;
                                finalStatus = '';

                                break;
                            }
                          });
                        }
                      },
                      labelPadding: const EdgeInsets.all(2.0),
                      label: Text(
                        'Very-Urgent'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: vUrget,
                      elevation: 6.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  controller: _controllerForMessageTitle,
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: 1,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      hintText: 'Message Title'.tr()),
                )),
            Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  textAlignVertical: TextAlignVertical.top,
                  controller: _controllerForMessageBody,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      hintText: 'Add Message Body'.tr()),
                )),
            const SizedBox(
              width: 50,
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    for (var i = 0; i < widget.messageTo.length; i++) {
                      if (widget.messageTo[i] != 'null') {
                        Database().sendPrivateMessageToParent(
                            widget.grade,
                            widget.classs,
                            widget.messageTo[i],
                            Auth().currentUser!.email!.split('@').first,
                            _controllerForMessageTitle.text,
                            _controllerForMessageBody.text,
                            finalStatus);
                      } else {}
                    }
                  },
                  child: Text('Send !'.tr())),
            ),
            const SizedBox(
              height: 40,
            )
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
/// PRESENCES FOR DB
///
/// PRESENCES FOR DB
///
/// PRESENCES FOR DB
///
///
///
///
///
///
///
///
/// PRESENCES FOR DB
///
/// PRESENCES FOR DB
///
/// PRESENCES FOR DB
///
///
///
///
///
///
///
///
/// PRESENCES FOR DB
///
/// PRESENCES FOR DB
///
/// PRESENCES FOR DB
///
///
///
///

class PresencesCheck extends StatefulWidget {
  String grade;
  String classs;

  PresencesCheck({Key? key, required this.grade, required this.classs})
      : super(key: key);
  @override
  State<PresencesCheck> createState() => _PresencesCheckState();
}

class _PresencesCheckState extends State<PresencesCheck> {
  bool selectAll = false;
  List<bool> checkBoxs = [];
  List<String> emails = [];
  int todayNum = DateTime.now().weekday;
  String todayDate =
      '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

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
                        builder: (BuildContext context) =>
                            const TeacherPanal()),
                    (Route<dynamic> route) => route is TeacherPanal);
              },
              icon: const Icon(Icons.output))
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: Text(
                            'Student name'.tr(),
                            style: Theme.of(context).textTheme.headline6,
                          )),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'select all'.tr(),
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Checkbox(
                                  value: selectAll,
                                  onChanged: (value) {
                                    setState(() {
                                      for (var i = 0;
                                          i < checkBoxs.length;
                                          i++) {
                                        checkBoxs[i] = value!;
                                      }
                                      selectAll = value!;
                                    });
                                  })
                            ],
                          )),
                    ],
                  ),
                  const Divider(),
                  FirebaseAnimatedList(
                    defaultChild: Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          const CircularProgressIndicator(),
                          const SizedBox(height: 20),
                          Text('Loading...'.tr()),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    query:
                        Database().getUsersOfClass(widget.grade, widget.classs),
                    itemBuilder: (context, snapshot, animation, index) {
                      Map mappingValue = snapshot.value as Map;
                      String emailsKeys = snapshot.key as String;
                      if (checkBoxs.length == index) {
                        checkBoxs.add(true);
                      }

                      if (emails.length == index) {
                        emails.add(emailsKeys);
                      }

                      return Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  child: Text(mappingValue['name'].toString())),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Checkbox(
                                        value: checkBoxs[index],
                                        onChanged: (value) {
                                          setState(() {
                                            checkBoxs[index] = value!;
                                          });
                                        }),
                                  )),
                              const Divider()
                            ],
                          ),
                          const Divider()
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                    onPressed: () {
                      for (var i = 0; i < checkBoxs.length; i++) {
                        // print(checkBoxs[i]);
                        Database().presnces(
                            emails[i], todayDate, todayNum, checkBoxs[i]);
                      }
                      Navigator.pop(context);
                    },
                    child: Text('Send !'.tr())),
              ),
            ),
            const SizedBox(
              height: 10,
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
/// ADD EVALUATION OF STUDENT FOR DB
///
/// ADD EVALUATION OF STUDENT FOR DB
///
/// ADD EVALUATION OF STUDENT FOR DB
///
///
///
///
///
///
///
///
/// ADD EVALUATION OF STUDENT FOR DB
///
/// ADD EVALUATION OF STUDENT FOR DB
///
/// ADD EVALUATION OF STUDENT FOR DB
///
///
///
///
///
///
///
///
/// ADD EVALUATION OF STUDENT FOR DB
///
/// ADD EVALUATION OF STUDENT FOR DB
///
/// ADD EVALUATION OF STUDENT FOR DB
///
///
///
///

class Evaluaion extends StatefulWidget {
  String classs;
  String grade;

  Evaluaion({Key? key, required this.grade, required this.classs})
      : super(key: key);
  @override
  State<Evaluaion> createState() => _EvaluaionState();
}

class _EvaluaionState extends State<Evaluaion> {
  String quizSelectedType = quizType.last;
  String errorMessage = '';
  final TextEditingController _controllerForExamMark = TextEditingController();
  // String metadataExamMarks = '';
  List<Map> data = [];
  //
  //
  // String grade;
  // String classs;
  String email = Auth().currentUser!.email!.split('@').first;

  // @override
  // void initState() {
  //   super.initState();
  //   Database()
  //       .ref
  //       .child('parent_feed/$email/evaluation')
  //       .onValue
  //       .listen((event) {
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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const TeacherPanal()),
                    (Route<dynamic> route) => route is TeacherPanal);
              },
              icon: const Icon(Icons.output_rounded))
        ],
        title: Text(AppMeta.appName),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                    child: Text(
                  'Quiz type'.tr(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
                DropdownButton<String>(
                  value: quizSelectedType,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.blue),
                  underline: Container(
                    height: 2,
                    color: Colors.blueAccent,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      quizSelectedType = value!;
                    });
                  },
                  items: quizType.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Exam mark'.tr(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 3.2,
                    child: Center(
                        child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _controllerForExamMark,
                      textAlignVertical: TextAlignVertical.top,
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        // hintText: ''
                      ),
                    ))),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3.2,
                  child: Center(
                      child: Text(
                    'Student name'.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3.2,
                  child: Center(
                      child: Text('Marks'.tr(),
                          style: Theme.of(context).textTheme.titleLarge)),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3.2,
                  child: Center(
                      child: Text('Comments'.tr(),
                          style: Theme.of(context).textTheme.titleLarge)),
                ),
              ],
            ),
            const Divider(),
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
              query: Database().getUsersOfClass(widget.grade, widget.classs),
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                Map mapValues = snapshot.value as Map;
                if (data.length == index) {
                  data.add({
                    'parent_email':
                        mapValues['email(id)'].toString().split('@').first,
                    'controller_of_mark': TextEditingController(),
                    'controller_of_comment': TextEditingController(),
                  });
                }

                return Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3.2,
                          child: Center(
                              child: Text(
                            mapValues['name'],
                            style: Theme.of(context).textTheme.titleMedium,
                          )),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 3.2,
                            child: Center(
                                child: TextField(
                              keyboardType: TextInputType.number,
                              controller: data[index]['controller_of_mark'],
                              textAlignVertical: TextAlignVertical.top,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ))),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3.2,
                          child: Center(
                              child: TextField(
                            keyboardType: TextInputType.text,
                            controller: data[index]['controller_of_comment'],
                            textAlignVertical: TextAlignVertical.top,
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          )),
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                    onPressed: () {
                      if (quizSelectedType == '' ||
                          _controllerForExamMark.text == '') {
                        setState(() {
                          errorMessage =
                              'Quiz type is not selected or exam marks is empty!';
                        });
                      } else {
                        // print(data.length);
                        for (var i = 0; i < data.length; i++) {
                          Database().sendMarks(
                              widget.grade,
                              widget.classs,
                              data[i]['parent_email'] ?? '',
                              email,
                              data[i]['controller_of_mark'].text ?? '',
                              data[i]['controller_of_comment'].text ?? '',
                              quizSelectedType,
                              _controllerForExamMark.text);
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Send !'.tr())),
              ),
            )
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
/// PERMISSIONS OF STUDENT FOR DB
///
/// PERMISSIONS OF STUDENT FOR DB
///
/// PERMISSIONS OF STUDENT FOR DB
///
///
///
///
///
///
///
///
/// PERMISSIONS OF STUDENT FOR DB
///
/// PERMISSIONS OF STUDENT FOR DB
///
/// PERMISSIONS OF STUDENT FOR DB
///
///
///
///
///
///
///
///
/// PERMISSIONS OF STUDENT FOR DB
///
/// PERMISSIONS OF STUDENT FOR DB
///
/// PERMISSIONS OF STUDENT FOR DB
///
///
///
///

class Permissions extends StatefulWidget {
  String grade;
  String classs;

  Permissions({super.key, required this.grade, required this.classs});

  @override
  State<Permissions> createState() => _PermissionsState();
}

class _PermissionsState extends State<Permissions> {
  final TextEditingController _controllerForReason = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppMeta.appName), actions: [
        IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const TeacherPanal()),
                  (Route<dynamic> route) => route is TeacherPanal);
            },
            icon: const Icon(Icons.output_rounded))
      ]),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: Center(
                        child: Text(
                      'Student name'.tr(),
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: Center(
                        child: Text('Request Quiting'.tr(),
                            style: Theme.of(context).textTheme.titleLarge)),
                  ),
                ],
              ),
              const Divider(),
              FirebaseAnimatedList(
                defaultChild: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      const CircularProgressIndicator(),
                      const SizedBox(height: 20),
                      Text('Loading...'.tr()),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                query: Database().getUsersOfClass(widget.grade, widget.classs),
                itemBuilder: (context, snapshot, animation, index) {
                  Map mappingValues = snapshot.value as Map;
                  return Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: Center(
                                child: Text(
                              mappingValues['name'],
                              style: Theme.of(context).textTheme.titleLarge,
                            )),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: Center(
                                child: ElevatedButton(
                              onPressed: () => showBottomSheet(
                                context: context,
                                builder: (context) => Column(
                                  children: [
                                    Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Text(
                                        'Quit Schedule'.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    )),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        controller: _controllerForReason,
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                            ),
                                            hintText:
                                                'Reason for parent..'.tr()),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: OutlinedButton(
                                          child: Text('Request'.tr()),
                                          onPressed: () {
                                            Database().quitRequest(
                                                mappingValues['email(id)']
                                                    .toString()
                                                    .split('@')
                                                    .first,
                                                _controllerForReason.text);
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ElevatedButton(
                                          child: Text('Close BottomSheet'.tr()),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    )
                                  ],
                                ),
                              ),
                              child: Text(
                                'Request'.tr(),
                              ),
                            )),
                          ),
                        ],
                      ),
                      const Divider()
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
